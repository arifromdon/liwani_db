class Sallary < ApplicationRecord
  belongs_to :employee

  def self.salary_employee(employee)

    datas = []
    employee.each do |data|
      list = {
        id: data.id,
        employee_name: data.employee_name,
        position: data.position,
        total_absent_monthly: data.total_absent_monthly,
        date: Time.now,
        monthly_deduction: data.sallary.present? ? data.sallary.monthly_deduction : 0,
        total_deduction: data.sallary.present? ? data.sallary.total_deduction : 0,
        salary_per_day: data.sallary.present? ? data.sallary.salary_per_day : 0,
        remaining_deduction: data.sallary.present? ? data.sallary.remaining_deduction : 0,
        total_salary: data.sallary.present? ? data.sallary.salary_per_day * data.total_absent_monthly : 0,
      }

      datas << list
    end

    return datas
  end

end
