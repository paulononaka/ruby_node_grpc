this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'ruson'
require 'discount_calculator_service'

def main
  Ruson.output_folder = './data/'
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(DiscountCalculatorService.new)
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main