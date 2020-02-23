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

    if is_black_friday
      return create_discount(product, 10)
    end

    discount = create_discount(product, 0)
    return discount if (user.nil?)

    if is_birthday(user)
      discount = create_discount(product, 5)
    end

    discount
  end

  def is_black_friday
    Date.today.day == 25 and Date.today.month == 11
  end

  def is_birthday(user)
    Date.today.day == user.date_of_birth.day and Date.today.month == user.date_of_birth.month
  end

  def create_discount(product, pct)
    return Proto::Discount.new(pct: 0, value_in_cents: 0) if pct == 0
    Proto::Discount.new(pct: pct, value_in_cents: product.price_in_cents * (1 - pct*0.01))
  end
end