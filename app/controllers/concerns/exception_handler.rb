module ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class InvalidDate < StandardError; end
  class InvalidParams < StandardError; end
  class RecordNotCreated < StandardError; end
  class ApiClientError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
    rescue_from ExceptionHandler::InvalidDate, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidParams, with: :four_twenty_two
    rescue_from ExceptionHandler::RecordNotCreated, with: :four_twenty_two
    rescue_from ExceptionHandler::ApiClientError, with: :bad_request_handler

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({}, e.message, 404, false, "Record not Found")
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({}, e.message, 422, false, "Unprocessable Entity")
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({}, e.message, 401, false, "Unauthorized")
  end

  def four_ninety_eight(e)
    json_response({}, e.message, 498, false, "Expired Signature")
  end

  def bad_request_handler(e)
    json_response({}, e.message, :bad_request, false)
  end

  def bad_request_handler(e)
    json_response({}, e.message, :bad_request, false)
  end
end
