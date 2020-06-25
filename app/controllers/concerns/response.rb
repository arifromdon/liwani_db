module Response
	def json_response(object, message = "", code = 200, status = true)
		payload = { data: object, meta: meta(code, status, message)}
		render json: payload, status: code
	end
  
	def meta(code, status, message)
		{
			code: code,
			status: status,
			message: message
		}
	end
end
