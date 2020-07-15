class SalaryHistory < ApplicationRecord

  belongs_to :employee, optional: true

  def self.create_history
    
    check = SalaryHistory.find_by(employee_id: self.employee.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    if check.present?
      return false
    else
      now = DateTime.now
      datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
      zone = ActiveSupport::TimeZone.new("Asia/Jakarta")
      entry_hour = self.entry_hour.in_time_zone(zone)
      work_hour = (datetime.to_i - entry_hour.to_datetime.to_i)
      sallary_per_minute = self.employee.salary.salary_per_day / (9 * 60)
      total = sallary_per_minute * work_hour

      Rails.logger.info "====================#{self}"
      Rails.logger.info "====================#{total}"
      # self.create(
      #   salary_per_day: self.employee.salary.salary_per_day,
      #   total_salary: total,
      #   monthly_deduction: self.monthly_deduction,
      #   total_deduction: self.total_deduction,
      #   work_hours: self.work_hours,
      #   remaining_deduction: self.remaining_deduction
      # )
    end
  end
end
