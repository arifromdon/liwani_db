module Api::V1

  class AbsentController < Api::ApplicationController

    def index

      @data = Absent.all

      json_response({ data: @data })

    end

    def create

      @data = Employee.all

      json_response({ data: @data })

    end

    def update

      @data = Absent.find_by( id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Data absent tidak ditemukan", 404)
      end

      @data.entry_hour = params[:entry_hour]
      @data.out_hour = params[:out_hour]
      @data.date = params[:date]
      @data.status_absent = params[:status_absent]

      if @data.save
        json_response({ data: @data }, "Data absent berhasil diubah", 200)
      else
        json_response({}, "Data absent gagal diubah", 400)
      end

    end

  end

end