module Api::V1

  class SalaryController < Api::ApplicationController

    def index
      @data = Sallary.all

      json_response({ data: @data })
    end

    def update_salary

      @data = Sallary.find_by( id: params[:id] )
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

      @data = Sallary.find_by( id: params[:id] )

      if @data.nil?
        json_response({ salary: {} }, "Data kasbon tidak ditemukan", 404)
      end

      @data.total_deduction = params[:total_deduction]
      @data.term_cash_receipt = params[:term_cash_receipt]
      @data.monthly_deduction_cash_receipt = params[:monthly_deduction_cash_receipt]
      @data.cash_receipt_date = params[:cash_receipt_date]

      if @data.save
        json_response({ data: {@data}, "Data kasbon berhasil diubah", 200 })
      else
        json_response({}, "Data kasbon gagal diubah", 400)
      end

    end

    def export_salary
    end

  end

end
