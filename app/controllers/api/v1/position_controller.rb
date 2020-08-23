module Api::V1

  class PositionController < Api::ApplicationController

    def index
      @data = Position.all

      json_response({ data: @data }, "Berhasil", 200)
    end

    def create

      @data = Position.create_position(params)

      if @data
        json_response(@data, "Jabatan berhasil ditambahkan", 200)
      else
        json_response({}, "Jabatan gagal ditambahkan", 400)
      end

    end

    def update
       @data = Position.find_by( id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Data posisi tidak ditemukan", 404)
      end

      @data.position_name = params[:position_name]
      @data.positional_allowance = params[:positional_allowance]
      @data.transportation_allowance = params[:transportation_allowance]
      @data.meal_allowances = params[:meal_allowances]
      @data.salary = params[:salary]

      if @data.save
        json_response({ data: @data }, "Position berhasil diubah", 200)
      else
        json_response({}, "Position gagal diubah", 400)
      end
    end

    def delete
      @data = Position.find_by( id: params[:id] )

      if @data.destroy!
        json_response({ data: @data }, "Position berhasil dihapus", 200)
      else
        json_response({}, "Position gagal dihapus", 400)
      end
    end

  end

end