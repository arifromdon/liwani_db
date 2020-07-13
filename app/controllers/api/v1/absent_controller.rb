module Api::V1

  class AbsentController < Api::ApplicationController

    def index

      @data = Absent.all.page(params[:page]).per(params[:per])

      render 'api/v1/absent/index.json.jbuilder'

    end

    def show
      @data = Employee.find_by( id: params[:id])

      if @data.present?
        json_response({ data: @data.absents }, "Data absent berhasil ditampilkan", 200)
      else
        json_response({}, "Data absent gagal ditampilkan", 404)
      end
    end

    def create

      data_employee = Employee.find_by(email: params[:email])

      if data_employee.nil?
        json_response({}, "Data karyawan tidak ada", 400)
      else
        @data = Absent.create_absent(data_employee)
        Rails.logger.info "#{@data}"
        if @data[0] == true
          json_response({ data: @data }, @data[1], 200)
        else
          json_response({}, @data[1], 404)
        end
      end

    end

    def update

      @data = Absent.find_by( id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Data absent tidak ditemukan", 404)
      end

      if params[:status_absent] == 'masuk'
        @data.entry_hour = Time.now
      else
        @data.out_hour = Time.now
        @data.employee.total_absent += 1
        @data.employee.total_absent_monthly += 1
      end

      @data.status_absent = params[:status_absent]

      if @data.save
        @data.employee.save

        json_response({ data: @data }, "Data absent berhasil diubah", 200)
      else
        json_response({}, "Data absent gagal diubah", 400)
      end

    end

  end

end