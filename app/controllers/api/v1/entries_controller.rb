class Api::V1::EntriesController < Api::V1::ApiBaseController
  def index
    # As we are sharing attr_reader :current_user, this current_user is the one return from api base, before that was the one from devise
    render json: current_user.entries
  end
end
