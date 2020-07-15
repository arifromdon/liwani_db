class Sallary < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :absent

  def self.salary_employee(employee)

    datas = []
    employee.each do |data|
      now = DateTime.now
      datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
      zone = ActiveSupport::TimeZone.new("Asia/Jakarta")
      entry_hour = self.entry_hour.in_time_zone(zone)
      work_hour = (datetime.to_i - entry_hour.to_datetime.to_i) / 60

      sallary_per_minute = self.employee.sallary.salary_per_day.to_f / (9 * 60).to_f
      total = sallary_per_minute * work_hour
      
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
        total_salary: total,
      }

      datas << list
    end

    return datas
  end

end
