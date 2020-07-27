module Api::V1

	class StockController < Api::ApplicationController

		def index
      @data = Stock.all.page(params[:page]).per(params[:per])
      @data = @data.filter_stock_name(params[:stock_name]) unless params[:stock_name].blank?
      @data = @data.filter_actor(params[:actor]) unless params[:actor].blank?
      @data = @data.page(params[:page]).per(params[:per])
      @pagination = {
        current_page: @data.current_page,
        next_page: @data.next_page,
        prev_page: @data.prev_page,
        total_page: @data.total_pages
      }

      json_response({ data: @data, pagination: @pagination }, "Berhasil", 200 )

    end

    def show
      @data = Stock.find_by( id: params[:id] )

      if @data.present?
        json_response({ data: @data}, "Data stock berhasil ditampilkan", 200)
      else
        json_response({}, "Data stock gagal ditampilkan", 404)
      end
    end

		def create

      @data = Stock.new
      @data.stock_name = params[:stock_name]
      @data.in_stock = params[:in_stock]
      @data.price_stock = params[:price_stock]
      @data.current_stock += @data.in_stock
      @data.total_stock = @data.total_stock + @data.current_stock + @data.out_stock
      @data.total_price_stock = @data.price_stock * @data.total_stock
      @data.date_in = Time.now

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
      @data.actor = params[:actor]
      @data.current_stock = @data.current_stock + @data.in_stock - @data.out_stock
      @data.total_stock = @data.total_stock + @data.in_stock
      @data.total_price_stock = @data.price_stock * @data.total_stock
      @data.date_in = Time.now
      @data.date_out = Time.now

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
