json.data @data.each do |data|
  json.id data.id
  json.employee_id data.employee_id
  json.employee_name data.employee.employee_name
  json.email data.employee.email
  json.phone_number data.employee.phone_number
  json.position data.employee.position
  json.status data.employee.status
  json.entry_hour data.entry_hour
  json.out_hour data.out_hour
  json.active data.active
  json.status_absent data.status_absent
  json.date data.date
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