json.data @data.each do |data|
  json.id data.id
  json.employee_name data.employee_name
  json.position data.position
  json.total_absent_monthly data.total_absent_monthly
  json.date Time.now
  json.monthly_deduction data.sallary.present? ? data.sallary.monthly_deduction : 0
  json.total_deduction data.sallary.present? ? data.sallary.total_deduction : 0
  json.salary_per_day data.sallary.present? ? data.sallary.salary_per_day : 0
  json.remaining_deduction data.sallary.present? ? data.sallary.remaining_deduction : 0
  json.meal_allowance data.sallary.present? ? data.sallary.meal_allowance : 0
  json.transport_allowance data.sallary.present? ? data.sallary.transport_allowance : 0
  json.positional_allowance data.sallary.present? ? data.sallary.positional_allowance : 0
  json.total_salary data.sallary.present? ? data.sallary.total_salary : 0
end

json.meta do 

  json.code 200
  json.message "Berhasil"
  json.status true

end


json.pagination do
  
  json.current_page @data.current_page
  json.next_page @data.next_page
  json.prev_page @data.prev_page
  json.total_page @data.total_pages

end