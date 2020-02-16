require 'discount_calculator_services_pb'

class DiscountCalculatorService < DiscountCalculator::Service
  def get_discount(point, _call)
    Product.new(id: '1',
                price_in_cents: 100,
                title: 'Some product',
                description: 'Some description')
  end
end