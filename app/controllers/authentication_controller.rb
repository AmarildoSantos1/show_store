# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  def authenticate
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = generate_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def register
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      token = generate_token(user.id)
      render json: { token: token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def generate_token(user_id)
    JWT.encode({ user_id: user_id }, Rails.application.secrets.secret_key_base)
  end
end
