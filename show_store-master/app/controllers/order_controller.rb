class OrderController < ActionController::API
  before_action :authenticate_request

  def index
    orders = @current_user.orders

    order_list = orders.map do |order|
      {
        order_id: order.id,
        status: order.status,
        created_at: order.created_at,
        items: order.items
      }
    end

    render json: order_list, status: :ok
  end

  def create
    order = Order.new(user_id: @current_user.id, status: params[:status])

    params[:item_ids].each do |item_id|
      order.order_items.build(item_id: item_id)
    end

    if order.save
      render json: order, status: :created
    else
      render json: { error: order.errors.full_messages }, status: :bad_request
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