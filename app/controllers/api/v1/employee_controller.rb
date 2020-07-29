module Api::V1

  class EmployeeController < Api::ApplicationController

    def index

      @data = Employee.all
      @data = @data.filter_jabatan(params[:jabatan]) unless params[:jabatan].blank?
      @data = @data.filter_status(params[:status_employee]) unless params[:status_employee].blank?
      @data = @data.page(params[:page]).per(params[:per])
      @pagination = {
        current_page: @data.current_page,
        next_page: @data.next_page,
        prev_page: @data.prev_page,
        total_page: @data.total_pages
      }

      # json_response({ data: @data, pagination: @pagination }, "Berhasil", 200)
      render 'api/v1/employee/index.json.jbuilder'
    end

    def show

      @data = Employee.find_by( id: params[:id] )

      json_response(data: @data)

    end

    def create

      @data = Employee.create_employee(params)

      if @data
        json_response({ data: @data }, "Karyawan berhasil ditambahkan", 200)
      else
        json_response({}, "Karyawan gagal ditambahkan", 400)
      end

    end

    def update

      @data = Employee.find_by( id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Karyawan tidak ditemukan", 404)
      end

      @data.employee_name = params[:employee_name]
      @data.email = params[:email]
      @data.phone_number = params[:phone_number]
      @data.position = params[:position]
      @data.status = params[:status]
      @data.join = params[:join]

      if @data.save
        json_response({ data: @data }, "Karyawan berhasil diubah", 200)
      else
        json_response({}, "Karyawan gagal diubah", 400)
      end

    end

    def delete

      @data = Employee.find_by( id: params[:id] )

      if @data.destroy!
        json_response({ data: @data }, "Karyawan berhasil dihapus", 200)
      else
        json_response({}, "Karyawan gagal dihapus", 400)
      end

    end

  end

end