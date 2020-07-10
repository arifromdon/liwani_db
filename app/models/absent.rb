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

end
