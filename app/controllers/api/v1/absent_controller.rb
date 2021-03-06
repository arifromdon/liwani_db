module Api::V1

  class AbsentController < Api::ApplicationController

    def index

      @data = Absent.joins(:employee).where("absents.created_at between ? and ?", Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).where("employees.id is not null")
      @data = @data.page(params[:page]).per(params[:per])

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

      data_employee = Employee.find_by(phone_number: params[:phone_number])

      if data_employee.nil?
        json_response({}, "Data karyawan tidak ada", 400)
      else
        @data = Absent.create_absent(data_employee)

        if @data[0] == true
          json_response({ data: @data[2] }, @data[1], 200)
        else
          json_response({}, @data[1], 404)
        end
      end

    end

    def update

      @data = Absent.find_by( employee_id: params[:id] )

      if @data.nil?
        json_response({ data: {} }, "Data absent tidak ditemukan", 404)
      else
        createCutiHistory = CutiHistory.new
        status = ""
        if params[:status_absent] == 'masuk'
          @data.entry_hour = Time.now
        elsif params[:status_absent] == 'keluar'
          if !@data.status_absent.eql?("masuk")
            status = "invalid_order"
          else
            now = DateTime.now
            datetime = DateTime.parse(now.strftime("%Y-%m-%dT17:00:00%z")).to_datetime
            zone = ActiveSupport::TimeZone.new("Asia/Jakarta")
            entry_hour = @data.entry_hour.in_time_zone(zone)
            work_hour = (datetime.to_i - entry_hour.to_datetime.to_i)

            @data.out_hour = Time.now
            @data.employee.total_absent += 1
            @data.employee.total_absent_monthly += 1
            @data.employee.total_work_hour += work_hour
          end
        elsif params[:status_absent] == 'cuti'
          createCutiHistory.start_date = params[:start_date]
          createCutiHistory.end_date = params[:end_date]
          createCutiHistory.status = params[:status]
          createCutiHistory.sisa = @data.employee.leave_rasio - params[:sisa]
          @data.employee.leave_rasio -= params[:sisa]
          createCutiHistory.description = params[:description]
          createCutiHistory.employee_id = params[:employee_id]
        end

        if status.eql?("invalid_order")
          json_response({}, "Pegawai belum berstatus masuk atau sudah berstatus keluar", 400)
        else
          @data.status_absent = params[:status_absent]

          if @data.save
            if params[:status_absent] != 'masuk'
              @data.employee.save
              @data.create_history(params[:status_absent], params[:jabatan])
              createCutiHistory.save
            end

            json_response({ data: @data }, "Data absent berhasil diubah", 200)
          else
            json_response({}, "Data absent gagal diubah", 400)
          end
        end
      end

    end

  end

end