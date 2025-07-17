class Api::V1::AuthController < Api::V1::ApiBaseController
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      render json: { token: JsonWebToken.encode({ sub: user.id }) }, status: :ok
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end
end
