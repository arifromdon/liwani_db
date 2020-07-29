class Absent < ApplicationRecord

  scope :active, ->{where(active:1)}
  enum status_absent: [:masuk, :alpa, :izin, :cuti, :belum_absen, :keluar, :sakit, :izin_setengah_hari]
  belongs_to :employee

  COMMON_YEAR_DAYS_IN_MONTH = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  def self.days_in_month(month, year = Time.now.year)
     return 29 if month == 2 && Date.gregorian_leap?(year)
     COMMON_YEAR_DAYS_IN_MONTH[month]
  end

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
      return true, "Absent berhasil dibuat", create
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

  def create_history(status)

    check = SalaryHistory.find_by(employee_id: self.employee.id, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)

    if check.present?
      return false
    else
      now = DateTime.now
      datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
      zone = ActiveSupport::TimeZone.new("Asia/Jakarta")

      total_day = Absent.days_in_month(Time.now.month, Time.now.year)
      salary_per_day = self.employee.position.salary / (total_day - 4)
      checkMonth = Absent.where(employee_id: self.employee.id, created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      salary_histories = SalaryHistory.where(employee_id: self.employee.id, created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month)
      total = 0


      if status === "alpa"
        total = 0
      elsif status === "izin"
        total = salary_per_day

        if checkMonth.where(status_absent: :izin).count > 2
          total = 0
        end
      elsif status === "cuti"
        total = salary_per_day
      elsif status === "keluar"
        total = salary_per_day
      elsif status === "sakit"
        total = salary_per_day

        if checkMonth.where(status_absent: :sakit).count > 3
          total = 0
        end
      elsif status === "izin_setengah_hari"
        total = salary_per_day
        if self.employee.position.id == 6
          total = self.employee.position.salary / 2
        end

        if checkMonth.where(status_absent: :izin_setengah_hari).count > 3
          total = 0
        end
      end
 
      total_all = 0

      if salary_histories.empty?
        total_all = total
      else
        salaries = salary_histories.pluck(:salary_per_day)  
        total_all = salaries.inject(0){|sum,x| sum + x }
        Rails.logger.info "===================#{total_all}"
      end

      create = SalaryHistory.new
      create.salary_per_day = total
      create.total_salary = total_all
      # create.monthly_deduction = self.employee.sallary.present? ? self.employee.sallary.monthly_deduction : 0
      # create.total_deduction = self.employee.sallary.present? ? self.employee.sallary.total_deduction : 0
      # create.work_hours =  self.employee.total_work_hour
      # create.remaining_deduction =  self.employee.sallary.present? ? self.employee.sallary.remaining_deduction : 0
      create.employee_id = self.employee.id

      create.save!
    end
  end

end
