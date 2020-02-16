require './lib/discount_calculator_service'
require './lib/discount_calculator_pb'

RSpec.describe DiscountCalculatorService do

  before do
    @discount_calculator = DiscountCalculatorService.new
  end

  context "when calling get_discount" do
    it "returns a product" do
      result = @discount_calculator.get_discount(User.new, nil)

      expect(result).to be_a_kind_of(Product)
    end
  end
end
