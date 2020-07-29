class Position < ApplicationRecord
  has_one :employee

  def self.create_position(params)

    create = Position.create(
      position_name: params[:position_name],
      positional_allowance: params[:positional_allowance],
      transportation_allowance: params[:transportation_allowance],
      meal_allowances: params[:meal_allowances],
      salary: params[:salary]
    )

  end

end
