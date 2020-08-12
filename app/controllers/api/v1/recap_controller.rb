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
      histories = SalaryHistory.all

      @data = []
      
      tanggal = params[:date].to_datetime
      
      employees.each do |employee|

        if employee.cash_receipts.active.present?
          hutang = employee.cash_receipts.active
          hutang.update_deduction(hutang.deduce_type, tanggal)
        end

        absent = employee.salary_histories.where(employee_id: employee.id, created_at: tanggal.beginning_of_month.beginning_of_day..tanggal.end_of_month.end_of_day)
        salaries = absent.pluck(:total_salary)  
        total_all = salaries.inject(0){|sum,x| sum + x }
        data = {
          employee: employee,
          salary_recap: total_all
          # salary_recap: {
          #   # salary_per_day: absent.salary_per_day,
          #   salary: absent.total_salary.count
          # }
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
      @historiesDeduction = CashReceiptHistory.where(created_at: tanggal.beginning_of_month..tanggal.end_of_month)
      # Rails.logger.info "=============#{CashReceiptHistory.where(created_at: tanggal.beginning_of_month..tanggal.end_of_month)}"
      @data = Employee.where(id: @histories.pluck(:employee_id))

      render "api/v1/recap/index.json.jbuilder"

    end

    def recap_per_employee
      
      @histories = SalaryHistory.where(employee_id: params[:id])
      @data = Employee.where(id: @histories.pluck(:employee_id))

      render "api/v1/recap/recap_per_employee.json.jbuilder"
    end

  end

end
