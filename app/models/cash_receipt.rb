class CashReceipt < ApplicationRecord

	belongs_to :employee, optional: true
	has_many 	 :cash_receipt_histories, optional: true

	enum deduce_type: [:monthly, :weekly]

	scope :active, ->{where(status:true)}

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

	def update_deduction(d_type, tanggal)

		Rails.logger.info "========== #{self}"

		if d_type == 0
			# check = (tanggal.to_datetime.year * 12 + tanggal.to_datetime.month) - (self.created_at.year * 12 + self.created_at.month)
			
			if DateTime.now != DateTime.now.end_of_month
				if DateTime.now.end_of_month.strftime("%A") == "Sunday"
					return false if DateTime.now != DateTime.now.end_of_month - 1
				end
			end

			if self.cash_receipt_histories.present?
				return false if Date.now.strftime("%m") == self.cash_receipt_histories.last.created_at.strftime("%m")
			else
				return false if Date.now.strftime("%m") == self.created_at.strftime("%m")
			end
		else

			return false if DateTime.now.strftime("%A") != "Saturday" and Time.now < "17:00".to_time 

			if self.cash_receipt_histories.present?
				last = self.cash_receipt_histories.last
				return false if (last.next_week.beginning_of_week..last.next_week.end_of_week).include?(Date.now)
			else
				return false unless (self.created_at.next_week.beginning_of_week..self.created_at.next_week.end_of_week).include?(Date.now)
			end
		end
		
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
			self.cash_receipt_histories.create(
				total_deduct: self.cash_receipt_term,
				remaining_deduction: self.rest_receipt_term - self.cash_receipt_term
			)
			return true
		else
			return false
		end
		
	end
end
