module Api::V1
	class AuthenticationsController < Api::ApplicationController
		skip_before_action :authorize_request, only: [:authenticate, :request_token]

		# request token for user
		def request_token
			auth_user = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
			
			json_response({ user: auth_user })
		end

		private
		# authentication params permissions
		def auth_params
			params.permit(:email, :password)
		end
	end
end
