class Employee < ApplicationRecord

  enum position: [:admin, :general_manager, :manager, :kepala_kebun, :pengawas, :karyawan, :petani]
  enum status: [:tetap, :kontrak, :harian]
  has_many :absents

end
