require 'discount_calculator_services_pb'
require 'models/product'

class DiscountCalculatorService < Proto::DiscountCalculator::Service
  def get_discount(discount_request, _call)
    product = Product.find(discount_request.product_id)

    return Proto::Product.new if (product.nil?)

    Proto::Product.new(id: product.id.to_s,
                price_in_cents: product.price_in_cents,
                title: product.title,
                description: product.description,
                discount: Proto::Discount.new(pct: 1, value_in_cents: 1000))
  end
end