json.data @data.each do |data|
  json.employee_id data.id
  json.employee_name data.employee_name
  json.phone_number data.phone_number
  json.position data.position
  json.status data.status
  total_salary = 0
  data.salary_histories.each do |salary| 
    json.salary_per_day salary.salary_per_day
    json.work_hours salary.work_hours
    json.monthly_deduction salary.monthly_deduction
    json.total_deduction salary.total_deduction
    json.remaining_deduction salary.remaining_deduction
    total_salary += salary.total_salary
  end

  data.cash_receipts do |item|
    item.cash_receipt_histories do |dataDeduction|
      json.item item
    end
  end

  json.total_salary total_salary + data.position.positional_allowance + data.position.transportation_allowance + data.position.meal_allowances
end

json.meta do 

  json.code 200
  json.message "Berhasil"
  json.status true

end