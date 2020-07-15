json.data @data.each do |data|
  now = DateTime.now
  datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
  zone = ActiveSupport::TimeZone.new("Asia/Jakarta")
  Rails.logger.info "===============#{data.sallary.inspect}"
  # json.id data.id
  # json.employee_name data.employee_name
  # json.position data.position
  # json.total_absent_monthly data.total_absent_monthly
  # json.date Time.now
  # json.monthly_deduction data.sallary.monthly_deduction
  # json.total_deduction data.sallary.total_deduction
  # json.salary_per_day data.sallary.salary_per_day
  # json.remaining_deduction data.sallary.remaining_deduction
  
  data.absents.each do |dataAbsent| 

    Rails.logger.info "======== data: #{data.inspect}"

    entry_hour = dataAbsent.entry_hour.in_time_zone(zone)
    work_hour = (datetime.to_i - entry_hour.to_datetime.to_i) / 60
    sallary_per_minute = data.sallary.salary_per_day.to_f / (9 * 60).to_f rescue 0
    total = sallary_per_minute * work_hour

    json.total_salary total
  end
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