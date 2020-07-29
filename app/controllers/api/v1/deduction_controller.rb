module Api::V1

  class DeductionController < Api::ApplicationController

  	before_action :get_employee, except: [:index, :show]
  	before_action :check_active, only: [:create, :detail_by_employee, :update]

    def index

		@page = params[:page].present? ? params[:page] : 1
		@per  = params[:per].present? ? params[:per] : 10

		@data = CashReceipt.all.page(@page).per(@per) || []

      	if @data.empty?
			json_response(@data, "Data tidak ada.", 404 )
		else
			json_response(@data, "Data berhasil didapatkan.", 200 )
		end
    end

    def show
    	@data = CashReceipt.find_by(id: params[:id]) || {}

		if @data.empty?
			json_response(@data, "Data tidak ada.", 404 )
		else
			json_response(@data, "Data berhasil didapatkan.", 200 )
		end
		
    end

    def by_employee
    	@page = params[:page].present? ? params[:page] : 1
		@per  = params[:per].present? ? params[:per] : 10

		@data = @employee.cash_receipts.page(@page).per(@per)

		if @data.empty?
			json_response(@data, "Data tidak ada.", 404 )
		else
			json_response(@data, "Data berhasil didapatkan.", 200 )
		end
    end

    def detail_by_employee
    	if @active.present?
			json_response(@active.last, "Data berhasil didapatkan.", 200 )
		else
			json_response({}, "Data tidak ada.", 404 )
		end
    end

    def create

    	if @active.present?
    		json_response({}, "Masih memiliki deduction aktif.", 400 )
    	else
    		create = CashReceipt.let_deduce(params, @employee)

    		if create[0] == true
				json_response(create[2], create[1], 200 )
			else
				json_response({}, create[1], 400 )
			end
    	end

    end

    def update
    	if @active.present?
			if @active.last.update_deduction
				json_response(@active.last, "Data berhasil diubah.", 200 )
			else
				json_response({}, "Gagal mengubah data.", 400 )
			end
		else
			json_response({}, "Data tidak ada.", 404 )
		end
    end


    private


    def get_employee
    	@employee = Employee.find_by(id: params[:id]) ||Employee.find_by(id: params[:employee_id])
    	if !@employee.present?
    		json_response( {data: {} }, "Employee not found", 404 )
    	end
    	
    end

    def check_active
    	@active = @employee.cash_receipts.where(status: true)
    end

  end

end