module Api::V1

  class Api::V1::RecapController < ApplicationController

    def index

      @data = Rekap.all

      json_response({ data: @data })

    end

    def export_salary
    end

    def export_stock
    end

    def export_all
    end

  end

end
