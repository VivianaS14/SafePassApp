class Api::V1::ApiBaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_json_format

  private

  # For always dealing with JSON
  def set_json_format
    request.format = :json
  end
end
