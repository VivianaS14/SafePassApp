class Api::V1::ApiBaseController < ApplicationController
  # This is for other controllers to read @current_user
  # attr_writer | attr_accessor are ruby methods to share instance variables
  attr_reader :current_user

  skip_before_action :verify_authenticity_token

  # To Lock ALL api routes
  before_action :authenticate_token
  before_action :set_json_format

  private

  def authenticate_token
    payload = JsonWebToken.decode(auth_token)
    if payload[:error]
      render json: { errors: [ payload[:error] ] }, status: :unauthorized
    else
      @current_user = User.find(payload["sub"])
    end
  end

  def auth_token
    @auth_token ||= request.headers["Authorization"]&.split(" ")&.last
  end

  # For always dealing with JSON
  def set_json_format
    request.format = :json
  end
end
