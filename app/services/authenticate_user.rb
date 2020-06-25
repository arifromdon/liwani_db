class AuthenticateUser


	def initialize(email, password)
		@email = email
		@password = password
	end

	def call
		{token: JsonWebToken.encode(user_id: user.id), user: user} if user
	end

	private

		attr_reader :email, :password

		def user
			user = User.find_by(email: @email)
	      	return user if user && user.valid_password?(@password)
			raise(ExceptionHandler::AuthenticationError, "User Not Found")
		end

end