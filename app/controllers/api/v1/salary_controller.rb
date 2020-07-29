module Api::V1

  class SalaryController < Api::ApplicationController

    def index
      data_employee = Employee.all

      if data_employee.nil?
        # json_response({}, "Data karyawan tidak ada", 400)
      else
        @data = data_employee.page(params[:page]).per(params[:per])

        render 'api/v1/salary/index.json.jbuilder'
      end
    end

    def show
      data_employee = Employee.find_by( id: params[:id])

      if data_employee.nil?
        # json_response({}, "Data karyawan tidak ada", 400)
      else
        @data = data_employee
        render 'api/v1/salary/detail.json.jbuilder'
      end
    end

    def update_salary

      @data = Sallary.find_by(employee_id: params[:id])

      if @data.nil?
        json_response({ data: {} }, "Stock tidak ditemukan", 404)
      end

      @data.salary_per_day = params[:salary_per_day]

      if @data.save
        json_response({ data: @data }, "Data upah berhasil diubah", 200)
      else
        json_response({}, "Data ubah gagal diubah", 400)
      end

    end

    def update_cash_receipt

      @data = Sallary.find_by( employee_id: params[:id] )

      if @data.nil?
        json_response({ salary: {} }, "Data kasbon tidak ditemukan", 404)
      end

      @data.total_deduction = params[:total_deduction]
      @data.term_cash_receipt = params[:term_cash_receipt]
      @data.monthly_deduction = params[:monthly_deduction]
      @data.cash_receipt_date = Time.now
      @data.remaining_deduction = @data.total_deduction - @data.monthly_deduction

      if @data.save
        json_response({ data: @data }, "Data kasbon berhasil diubah", 200)
      else
        json_response({}, "Data kasbon gagal diubah", 400)
      end

    end

    def export_salary
    end

  end

end
