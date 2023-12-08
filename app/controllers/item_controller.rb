class ItemController < ActionController::API
  before_action :authenticate_request

  def index
    items = Item.where('quantity > 0').all

    items_list = items.map do |item|
      {
        id: item.id,
        name: item.name,
        description: item.description,
        price: item.price,
        quantity: item.quantity,
        image_url: item.image_url
      }
    end

    render json: items_list, status: :ok
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