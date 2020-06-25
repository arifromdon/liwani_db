class AuthorizeApiRequest

	def initialize(headers = {} )
		@headers = headers
	end

	def call
		{
			user: user
		}
	end

	private

		attr_reader :headers


		def user
			# find user and sign it to @user
			@user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token
		rescue ActiveRecord::RecordNotFound => e
			# raise custome error
			raise(ExceptionHandler::InvalidToken, ("#{Message.invalid_token} #{e.message}"))
		end

		def decode_auth_token
			# use decode method on JsonWebToken class to decode
			@decode_auth_token ||= JsonWebToken.decode(http_auth_header)
		end

		def http_auth_header
			# check if authorization present;
			if headers["Authorization"].present?
				return headers["Authorization"].split(" ").last
			end
			raise(ExceptionHandler::MissingToken, Message.missing_token)
		end


end