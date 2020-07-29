class CashReceipt < ApplicationRecord

	belongs_to :employee, optional: true

	enum deduce_type: [:monthly, :weekly]

	def self.let_deduce(params, employee)

		if params[:total_cash_receipt] > employee.position.salary 
			return false, "Peminjaman tidak boleh lebih dari gaji!"
		elsif params[:length_deduction] > 5
			return false, "Peminjaman tidak boleh lebih 5 kali pembayaran gaji!"
		end

		type =  employee.position.position_name.eql?("petani") ? :weekly : :monthly
		
		create = self.create(
			total_cash_receipt: params[:total_cash_receipt].to_i,
			monthly_deduction: 	params[:length_deduction].to_i,
			cash_receipt_term: 	params[:total_cash_receipt].to_i / params[:length_deduction].to_i ,
			rest_receipt_term: 	params[:total_cash_receipt].to_i,
			employee_id: employee.id,
			status: true,
			deduce_type: type
		)

		if create
			return true, "Berhasil melakukan deduction", create
		else
			return false, "Gagal menambahkan data!", nil
		end
		
	end

	def update_deduction

		Rails.logger.info "========== #{self}"
		
		if (self.rest_receipt_term - self.cash_receipt_term) <= 0
			status = false
		else
			status = true
		end

		update = self.update(
			rest_receipt_term: 	self.rest_receipt_term - self.cash_receipt_term,
			status: status
		)

		if update
			return true
		else
			return false
		end
		
	end
end
