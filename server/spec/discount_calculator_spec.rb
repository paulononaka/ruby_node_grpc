require './lib/discount_calculator_service'
require './lib/discount_calculator_pb'
require 'ruson'

RSpec.describe DiscountCalculatorService do

  before do
    Ruson.output_folder = './spec/data/'

    @product = Product.create(id: '1',
                              price_in_cents: 200,
                              title: 'Some product title',
                              description: 'Some product description')

    @discount_calculator = DiscountCalculatorService.new
  end

  after(:all) { FileUtils.rm_rf('./spec/data/') }

  context "when calling get_discount" do
    it "returns a proto Proto::Product" do
      discount_request = Proto::GetDiscountRequest.new(product_id: '1', user_id: '123')

      result = @discount_calculator.get_discount(discount_request, nil)

      expect(result).to be_a_kind_of(Proto::Product)
    end

    it "finds and returns the product passed by the request parameters" do
      discount_request = Proto::GetDiscountRequest.new(product_id: '1', user_id: '123')

      result = @discount_calculator.get_discount(discount_request, nil)

      expect(result.id).to eq(@product.id)
      expect(result.price_in_cents).to eq(@product.price_in_cents)
      expect(result.title).to eq(@product.title)
      expect(result.description).to eq(@product.description)
    end

    it "returns a empty Proto::Product when can not find product in the database" do
      discount_request = Proto::GetDiscountRequest.new(product_id: '999', user_id: '123')

      result = @discount_calculator.get_discount(discount_request, nil)

      expect(result).to be_a_kind_of(Proto::Product)
      expect(result.id).to be_empty
    end
  end
end
