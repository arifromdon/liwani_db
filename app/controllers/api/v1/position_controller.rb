module Api::V1

  class PositionController < Api::ApplicationController

    def index
      @data = Position.all

      json_response({ data: @data }, "Berhasil", 200)
    end

    # def show

    #   @data = Position.find_by( id: params[:id])

    #   if @data.present?
    #     json_response({ data: @data.absents }, "Data absent berhasil ditampilkan", 200)
    #   else
    #     json_response({}, "Data absent gagal ditampilkan", 404)
    #   end

    # end

    def create

      @data = Position.create_position(params)

      if @data
        json_response(@data, "Jabatan berhasil ditambahkan", 200)
      else
        json_response({}, "Jabatan gagal ditambahkan", 400)
      end

    end

    def update

    end

  end

end