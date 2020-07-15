class Absent < ApplicationRecord

  scope :active, ->{where(active:1)}
  enum status_absent: [:masuk, :alpa, :izin, :cuti, :belum_absen, :keluar]
  belongs_to :employee

  def self.create_absent(employee)
    if self.where(employee_id: employee.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).present?
      return false, "Data absent gagal dimasukan, data telah tersedia"
    end

    create = self.create!(
      date: Time.now,
      status_absent: "belum_absen",
      employee_id: employee.id,
      active: 1
    )

    if create 
      return true, "Absent berhasil dibuat"
    end

  end

  def self.active_absent
    absents = self.active

    datas = []
    absents.each do |data|
      list = {
        id: data.id,
        employee_name: data.employee.employee_name,
        email: data.employee.email,
        phone_number: data.employee.phone_number,
        position: data.employee.position,
        status: data.employee.status,
        entry_hour: data.entry_hour,
        out_hour: data.out_hour,
        active: data.active,
        status_absent: data.status_absent,
        date: data.date
      }

      datas << list
    end

    return datas
  end

  def create_history

    check = SalaryHistory.find_by(employee_id: self.employee.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    if check.present?
      return false
    else
      now = DateTime.now
      datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
      zone = ActiveSupport::TimeZone.new("Asia/Jakarta")
      entry_hour = self.entry_hour.in_time_zone(zone)
      work_hour = (datetime.to_i - entry_hour.to_datetime.to_i) / 60

      Rails.logger.info "=========== eh : #{entry_hour}"
      Rails.logger.info "=========== wh : #{work_hour}"

      sallary_per_minute = self.employee.sallary.present? ? self.employee.sallary.salary_per_day.to_f / (9 * 60).to_f : 0
      total = sallary_per_minute * work_hour

      create = SalaryHistory.new
      create.salary_per_day = self.employee.sallary.present? ? self.employee.sallary.salary_per_day : 0
      create.total_salary = total
      create.monthly_deduction = self.employee.sallary.present? ? self.employee.sallary.monthly_deduction : 0
      create.total_deduction = self.employee.sallary.present? ? self.employee.sallary.total_deduction : 0
      create.work_hours =  self.employee.total_work_hour
      create.remaining_deduction =  self.employee.sallary.present? ? self.employee.sallary.remaining_deduction : 0
      create.employee_id = self.employee.id

      Rails.logger.info "======================#{create.inspect}============"
      create.save!
    end
  end

end
