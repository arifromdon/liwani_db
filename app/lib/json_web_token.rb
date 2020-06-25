class JsonWebToken 
	# set signature 
	HMAC_SECRET = Rails.application.secrets.secret_key_base

	def self.encode(payload, exp =  2.month.from_now)
		# set expire to 24 hours 
		payload[:exp] = exp.to_i
		# sign token with application secret
		JWT.encode(payload, HMAC_SECRET)
	end

	def self.decode(token)
		# get payload; first index in decode array 
		body = JWT.decode(token, HMAC_SECRET)[0]
		HashWithIndifferentAccess.new(body)
		# rescue from all decode error 
	rescue JWT::DecodeError => e 
		# raise custom error to be handled by custome handler 
		raise ExceptionHandler::InvalidToken, e.message
	end
end