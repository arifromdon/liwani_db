json.data @data.each do |data|
  json.id data.id
  json.employee_name data.employee_name
  json.email data.email
  json.phone_number data.phone_number
  json.status data.status
  json.join data.join
  json.leave_rasio data.leave_rasio
  json.position_id data.position_id
  json.position data.position
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