# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: discount_calculator.proto for package ''

require 'grpc'
require 'discount_calculator_pb'

module DiscountCalculator
  class Service

    include GRPC::GenericService

    self.marshal_class_method = :encode
    self.unmarshal_class_method = :decode
    self.service_name = 'DiscountCalculator'

    rpc :GetDiscount, User, Product
  end

  Stub = Service.rpc_stub_class
end
