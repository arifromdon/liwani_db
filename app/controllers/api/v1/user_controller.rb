module Api::V1

  class UserController < Api::ApplicationController

    skip_before_action :authorize_request, only: [:reset_password_request, :check_token_password, :reset_password]

    def index

      @data = User.all

      json_response({ data: @data })

    end

    def create

      @data = User.new
      @data.email = params[:email]
      @data.password = params[:password]
      @data.status = params[:status]

      if @data.save
        json_response({ data: @data }, "User berhasil ditambahkan", 200)
      else
        json_response({}, "User gagal ditambahkan", 400)
      end

    end

    def update

      @data = User.find_by(email: current_user.email)

      if @data.nil?
        json_response({ data: {} }, "User tidak ditemukan", 404)
      end

      @data.email = params[:email]
      @data.password = params[:password]
      @data.password_confirmation = params[:password_confirmation]

      if @data.save
        json_response({ data: @data }, "User berhasil diubah", 200)
      else
        json_response({}, "User gagal diubah", 400)
      end
    end

    def reset_password_request
      @data = User.find_by(email: params[:email])

      if @data.present?
        o = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
        string = (0...25).map { o[rand(o.length)] }.join

        if @data.update(password_toke_reset: string)
          UserMailer.reset_password(@data).deliver_now
        end
        json_response({}, "Request forgot password berhasil. Silahkan cek email anda", 200)
      else
        json_response({}, "Data user tidak ada", 200)
      end

    end

    def check_token_password

      @data = User.find_by(password_toke_reset: Base64.decode64(params[:token]))

      if @data.present?
        json_response({}, "Token valid", 200)
      else
        json_response({}, "Token tidak valid", 400)
      end
      
    end

    def reset_password

      @data = User.find_by(password_toke_reset: Base64.decode64(params[:token]))

      if @data.present?
        @data.password = params[:password]
        @data.password_confirmation = params[:password_confirmation]

        if params[:password] === params[:password_confirmation]
          @data.password_toke_reset = ""
          @data.save

          json_response({}, "Password berhasil dirubah", 200)
        else
          json_response({}, "Password tidak sama dengan konfirmasi password, coba cek kembali", 400)
        end
      end
      

    end

  end
end
