module Api::V1

	class StockController < Api::ApplicationController

		def index

      @data = Stock.all

      json_response({ data: @data })

    end

		def create

      @data = Stock.new
      @data.stock_name = params[:stock_name]
      @data.in_stock = params[:in_stock]
      @data.price_stock = params[:price_stock]
      @data.date_in = params[:date_in]

      if @data.save
        json_response({ data: @data }, "Stock berhasil ditambahkan", 200)
      else
        json_response({}, "Stock gagal ditambahkan", 400)
      end
    end

    def update

      @data = Stock.find_by( id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Stock tidak ditemukan", 404)
      end

      @data.in_stock = params[:in_stock]
      @data.out_stock = params[:out_stock]
      @data.date_in = params[:date_in]
      @data.date_out = params[:date_out]

      if @data.save
        json_response({ data: @data }, "Stock berhasil diubah", 200)
      else
        json_response({}, "Stock gagal diubah", 400)
      end

    end

    def delete

      @data = Stock.find_by( id: params[:id] )

      if @data.destroy!
        json_response({ data: @data }, "Stock berhasil dihapus", 200)
      else
        json_response({}, "Stock gagal dihapus", 400)
      end

    end

	end

end
