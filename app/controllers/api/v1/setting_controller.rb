module Api::V1

  class SettingController < Api::ApplicationController

    def check_active_month

      if Time.now.strftime('%m %Y') > Employee.first.current_active_month.strftime('%m %Y')
        Employee.update_all(current_active_month: Time.now, work_hours: 0)

        json_response({}, 'Active month updated', 200)
      else
        json_response({}, 'Active month not update', 200)
      end

    end

  end
end