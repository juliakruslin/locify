class OrdersController < ApplicationController
  def create
    cart = Cart.find(params[:cart])
    order  = Order.create!(cart: cart, amount: cart.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: current_user.first_name,
        amount: cart.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
      )

    order.update(checkout_session_id: session.id)
    cart.update(status: 'ordered')
    redirect_to new_order_payment_path(order)
  end

  def show
    # @order = current_user.orders.find(params[:order_id])
    @order = current_user.orders.find(params[:id])
  end
end
