class Deduction < ApplicationRecord

  belongs_to :employee

  enum status: [ :active, :finish ]

  def create_deduction(params)
    data = Deduction.create!(
      employee_id: params[:employee],
      total_deduction: params[:total_deduction],
      remaining_deduction: params[:total_deduction],
      deduction_length: params[:deduction_length],
      status: :active
    )
  end

  def self.update_deduction
    remaining = self.remaining_deduction -  (self.total_deduction / self.deduction_length)
    self.update(
      remaining_deduction: remaining
    )

    if self.remaining.to_i <= 0
      self.status = :finish
      self.save!
    end
  end

end
