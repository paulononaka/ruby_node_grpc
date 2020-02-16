require 'discount_calculator_services_pb'

class DiscountCalculatorService < DiscountCalculator::Service
  def get_discount(getDiscountRequest, _call)
    Product.new(id: '1',
                price_in_cents: 100,
                title: 'Some product',
                description: 'Some description',
                discount: Discount.new(pct: 5.5, value_in_cents: 599))
  end
end