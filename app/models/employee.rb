class Employee < ApplicationRecord

  enum position: [:admin, :general_manager, :manager, :kepala_kebun, :pengawas, :karyawan, :petani]
  enum status: [:tetap, :kontrak, :harian]
  has_many :absents
  has_one :sallary

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
      employee_id: id
    )
  end

end
