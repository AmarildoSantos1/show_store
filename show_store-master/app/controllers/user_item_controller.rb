class UserItemController < ActionController::API
  before_action :authenticate_request

  def index
    user_items = @current_user.user_items.all

    render json: user_items, status: :ok
  end

  def create
    item = Item.find(params[:item_id])

    render json: { error: 'Item not found' }, status: :not_found and return unless item

    if @current_user.user_items.where(item: item).exists?
      item = UserItem.where( user: @current_user, item: item).first
      item.destroy

      render json: { message: 'Item removed from cart' }, status: :ok and return
    else
      user_item = UserItem.new(user: @current_user, item: item)

      render json: user_item, status: :created and return if user_item.save
    end

  end

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base)
      @current_user = User.find(decoded_token.first['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end
end