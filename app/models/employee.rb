class Employee < ApplicationRecord

  enum position: [:admin, :general_manager, :manager, :kepala_kebun, :pengawas, :karyawan, :petani]
  enum status: [:tetap, :kontrak, :harian]
  has_many :absents
  has_one :sallary
  has_many :salary_histories

  def self.create_employee(params)

    data = Employee.create(
      employee_name: params[:employee_name],
      email: params[:email],
      phone_number: params[:phone_number],
      position: params[:position],
      status: params[:status],
      join: params[:join]
    )

    create_sallary(params, data.id)
  end

  def self.create_sallary(params, id)
    Sallary.create(
      monthly_deduction: params[:monthly_deduction],
      total_deduction: params[:total_deduction],
      salary_per_day: params[:salary_per_day],
      remaining_deduction: params[:remaining_deduction],
      total_salary: params[:total_salary],
      meal_allowance: params[:meal_allowance],
      transport_allowance: params[:transport_allowance],
      positional_allowance: params[:positional_allowance],
      employee_id: id
    )
  end

  def self.filter_jabatan(jabatan)
    if jabatan.eql?('admin')
      return self.where(position: jabatan)
    elsif jabatan.eql?('karyawan')
      return self.where(position: jabatan)
    elsif jabatan.eql?('petani')
      return self.where(position: jabatan)
    elsif jabatan.eql?('kepala_kebun')
      return self.where(position: jabatan)
    end
  end

  def self.filter_status(status_employee)
    if status_employee.eql?('tetap')
      return self.where(status: status_employee)
    elsif status_employee.eql?('kontrak')
      return self.where(status: status_employee)
    elsif status_employee.eql?('harian')
      return self.where(status: status_employee)
    end
  end

  def get_sallary_monthly
    work_minute = self.total_work_hour / 60
    sallary_per_day = self.sallary.salary_per_day

    sallary_per_minute = sallary_per_day / (9 * 60)

    total = sallary_per_minute * work_minute

    return total

  end

end
