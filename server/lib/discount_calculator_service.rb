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
    discount = Proto::Discount.new(pct: 0, value_in_cents: 0)

    if Date.today.day == 25 and Date.today.month == 11
      discount = Proto::Discount.new(pct: 10, value_in_cents: product.price_in_cents * 0.90)
    end

    return discount if (user.nil?)

    if Date.today.day == user.date_of_birth.day and Date.today.month == user.date_of_birth.month
      discount = Proto::Discount.new(pct: 5, value_in_cents: product.price_in_cents * 0.95)
    end

    discount
  end
end