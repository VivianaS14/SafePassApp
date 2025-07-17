class Api::V1::EntriesController < ApplicationController
  def index
    render json: current_user.entries
  end
end
