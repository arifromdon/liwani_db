module Api::V1

  class UserController < Api::ApplicationController

    def index

      @data = User.all

      json_response({ data: @data })

    end

    def create

      @data = User.new
      @data.email = params[:email]
      @data.password = params[:password]

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

  end
end
