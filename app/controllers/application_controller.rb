class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def route_not_found
    render json: { error: "Route not found!" }, status: :not_found
  end

  def not_found(err = nil, message: "Resource not found!")
    render json: { error: err.try(:message) || message }, status: :not_found
  end
end
