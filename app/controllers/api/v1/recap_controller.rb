module Api::V1

  class RecapController < Api::ApplicationController

    def index

      date_from = Absent.first.created_at.strftime("%Y-%m-%d")
      date_to = Absent.last.created_at.strftime("%Y-%m-%d")
      date_range = date_from..date_to

      dates = []
      date_from.upto(date_to) { |date| dates << date.to_datetime.strftime("%B %Y") }

      date_months = dates.uniq

      json_response({ data: date_months })

    end

    def show_sallary
      employees = Employee.all

      @data = []

      date_now = Date.parse(params[:date])
      date_range = date_now.beginning_of_month..date_now.end_of_month

      employees.each do |employee|
        absent = employee.absents.where(created_at: date_range)
        data = {
          employee: employee,
          salary_recap: {
            total_attendance: absent.count,
            salary_per_day: employee.sallary.salary_per_day,
            salary: (employee.sallary.salary_per_day * absent.count) 
          }
        }
        @data << data
      end

      if @data
        json_response({ data: @data }, "Rekap data gaji berhasil ditampilkan", 200)
      elsif @data.blank?
        json_response({}, "Rekap data gaji kosong", 200)
      elsif
        json_response({}, "Rekap data gaji gagal ditampilkan", 400)
      end

    end

    def show_stock
      date_now = Date.parse(params[:date])
      date_range = date_now.beginning_of_month..date_now.end_of_month

      listStock = Stock.all.where(created_at: date_range)

      if listStock
        json_response({ data: listStock }, "Rekap data stok berhasil ditampilkan", 200)
      elsif listStock.blank?
        json_response({ data: listStock }, "Rekap data stok kosong", 200)
      elsif
        json_response({}, "Rekap data stok gagal ditampilkan", 400)
      end

    end

    def recap

      tanggal = params[:month].to_datetime

      @histories = SalaryHistory.where(created_at: tanggal.beginning_of_month..tanggal.end_of_month)
      @data = Employee.where(id: @histories.pluck(:employee_id))

      render "api/v1/recap/index.json.jbuilder"

    end

    def recap_per_employee
      
      @data = SalaryHistory.where(employee_id: params[:employee], create_at: Datetime.today).first 

    end

  end

end
