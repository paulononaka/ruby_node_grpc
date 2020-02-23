require './lib/discount_calculator_service'
require './lib/discount_calculator_pb'
require 'ruson'
require 'date'

RSpec.describe DiscountCalculatorService do

  context "when calling get_discount" do

    before do
      Ruson.output_folder = './spec/data/'
      @discount_calculator = DiscountCalculatorService.new
    end

    after(:all) do
      FileUtils.rm_rf('./spec/data/')
    end

    it "returns a empty Proto::Product when can not find product in the database" do
      FileUtils.rm_rf('./spec/data/')
      discount_request = Proto::GetDiscountRequest.new(product_id: '999', user_id: '999')

      result = @discount_calculator.get_discount(discount_request, nil)

      expect(result).to be_a_kind_of(Proto::Product)
      expect(result.id).to be_empty
    end

    context "there is a product in the database with price 200" do
      before do
        @product = Product.create(id: '1',
                                  price_in_cents: 200,
                                  title: 'Some product title',
                                  description: 'Some product description')
      end

      it "returns a proto Proto::Product" do
        discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '123')

        result = @discount_calculator.get_discount(discount_request, nil)

        expect(result).to be_a_kind_of(Proto::Product)
      end

      it "finds and returns the product passed by the request parameters" do
        discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '123')

        result = @discount_calculator.get_discount(discount_request, nil)

        expect(result.id).to eq(@product.id)
        expect(result.price_in_cents).to eq(@product.price_in_cents)
        expect(result.title).to eq(@product.title)
        expect(result.description).to eq(@product.description)
      end

      it "the product has no discount if can not find user" do
        FileUtils.rm_rf('./spec/data/Users/')
        discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '999')

        result = @discount_calculator.get_discount(discount_request, nil)

        expect(result.discount.pct).to eq(0)
        expect(result.discount.value_in_cents).to eq(0)
      end

      context "there is a user in the database celebrating an anniversary" do
        before do
          @user = User.create(id: '1',
                              first_name: 'Bart',
                              last_name: 'Simpson',
                              date_of_birth: Date.today - 10.years)
        end

        it "the product has 5% discount if it's the user's birthday" do
          discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: @user.id)

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(5)
          expect(result.discount.value_in_cents).to eq(190)
        end
      end
    end
  end
end
