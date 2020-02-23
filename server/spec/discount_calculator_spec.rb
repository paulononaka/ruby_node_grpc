require './lib/discount_calculator_service'
require './lib/discount_calculator_pb'
require 'ruson'
require 'date'
require 'timecop'

RSpec.describe DiscountCalculatorService do

  context "when calling get_discount" do

    before do
      Ruson.output_folder = './spec/data/'
      FileUtils.rm_rf('./spec/data/')
      @discount_calculator = DiscountCalculatorService.new
    end

    after(:all) do
      FileUtils.rm_rf('./spec/data/')
    end

    it "returns a empty Proto::Product when can not find product in the database" do
      discount_request = Proto::GetDiscountRequest.new(product_id: '999', user_id: '999')

      result = @discount_calculator.get_discount(discount_request, nil)

      expect(result).to be_a_kind_of(Proto::Product)
      expect(result.id).to be_empty
    end

    context "there is a product in the database with price 200 cents" do
      before do
        @product = Product.create(id: '1',
                                  price_in_cents: 200,
                                  title: 'Some product title',
                                  description: 'Some product description')
      end

      it "finds and returns the product passed by the request parameters" do
        discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '123')

        result = @discount_calculator.get_discount(discount_request, nil)

        expect(result.id).to eq(@product.id)
        expect(result.price_in_cents).to eq(@product.price_in_cents)
        expect(result.title).to eq(@product.title)
        expect(result.description).to eq(@product.description)
      end

      context "it is Black Friday (assuming BlackFriday is November 25th)" do
        before do
          Timecop.freeze(Time.local(1990, 11, 25))
        end

        it "the product has 10% discount" do
          discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '999')

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(10)
          expect(result.discount.value_in_cents).to eq(180)
        end

        it "discount is given even if can not find user" do
          FileUtils.rm_rf('./spec/data/Users/')
          discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: '999')

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(10)
          expect(result.discount.value_in_cents).to eq(180)
        end

        context "there is a user in the database celebrating an anniversary" do
          before do
            @user = User.create(id: '1',
                                first_name: 'Bart',
                                last_name: 'Simpson',
                                date_of_birth: Date.today - 10.years)
          end

          it "no product discount can be bigger than 10%" do
            discount_request = Proto::GetDiscountRequest.new(product_id: @product.id, user_id: @user.id)

            result = @discount_calculator.get_discount(discount_request, nil)

            expect(result.discount.pct).to eq(10)
            expect(result.discount.value_in_cents).to eq(180)
          end
        end
      end

      context "it is NOT Black Friday" do
        before do
          Timecop.freeze(Time.local(1990, 11, 20))
        end

        it "the product has no discount if can not find user and it is not Black Friday" do
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

    context "it is Black Friday (assuming BlackFriday is November 25th)" do
      before do
        Timecop.freeze(Time.local(1990, 11, 25))
      end

      context "there is a product in the database with price 2 cents" do
        before do
          @product2 = Product.create(id: '2',
                                     price_in_cents: 2,
                                     title: 'Some product title',
                                     description: 'Some product description')
        end

        it "trunc discount when can not be smaller" do
          discount_request = Proto::GetDiscountRequest.new(product_id: @product2.id, user_id: '999')

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(10)
          expect(result.discount.value_in_cents).to eq(1)
        end
      end

      context "there is a product in the database with price 3 cents" do
        before do
          @product3 = Product.create(id: '3',
                                     price_in_cents: 3,
                                     title: 'Some product title',
                                     description: 'Some product description')
        end

        it "trunc discount when can not be smaller" do
          discount_request = Proto::GetDiscountRequest.new(product_id: @product3.id, user_id: '999')

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(10)
          expect(result.discount.value_in_cents).to eq(2)
        end
      end

      context "there is a product in the database with free price" do
        before do
          @product4 = Product.create(id: '4',
                                     price_in_cents: 0,
                                     title: 'Some product title',
                                     description: 'Some product description')
        end

        it "ensures there is zero discount when product is already free" do
          discount_request = Proto::GetDiscountRequest.new(product_id: @product4.id, user_id: '999')

          result = @discount_calculator.get_discount(discount_request, nil)

          expect(result.discount.pct).to eq(0)
          expect(result.discount.value_in_cents).to eq(0)
        end
      end
    end
  end
end
