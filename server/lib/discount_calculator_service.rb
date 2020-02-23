require 'discount_calculator_services_pb'
require 'models/product'
require 'models/user'

class DiscountCalculatorService < Proto::DiscountCalculator::Service

  def get_discount(discount_request, _call)
    product = Product.find(discount_request.product_id)
    user = User.find(discount_request.user_id)

    return Proto::Product.new if (product.nil?)

    Proto::Product.new(id: product.id,
                       price_in_cents: product.price_in_cents,
                       title: product.title,
                       description: product.description,
                       discount: discount(product, user))
  end

  private

  def discount(product, user)
    no_discount = Proto::Discount.new(pct: 0, value_in_cents: 0)

    return no_discount if (user.nil?)

    if user.date_of_birth.day == Date.today.day and
        user.date_of_birth.month == Date.today.month
      Proto::Discount.new(pct: 5, value_in_cents: product.price_in_cents * 0.95)
    else
      no_discount
    end
  end
end