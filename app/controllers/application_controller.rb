class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  private 
  
  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404))
      .serialize_json, status: :not_found
  end

  def invalid(exception)
    if exception.message.include?("been taken")
      status_code = 422
    elsif exception.message.include?("must exist")
      status_code = 404
    else 
      status_code = 400
    end 
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, status_code))
        .serialize_json, status: status_code
  end
end
