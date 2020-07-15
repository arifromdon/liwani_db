json.data @data.each do |data|
  
  json.employee_id data.id
  json.employee_name data.employee_name
  total_salary = 0
  data.salary_histories.each do |salary| 
    json.work_hours salary.work_hours
    total_salary += salary.total_salary
  end

  json.total_salary total_salary
end

json.meta do 

  json.code 200
  json.message "Berhasil"
  json.status true

end