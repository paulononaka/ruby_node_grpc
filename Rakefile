task default: %w[server]

task :generate_proto do
  sh 'grpc_tools_ruby_protoc -I protos --ruby_out=server/lib --grpc_out=server/lib protos/discount_calculator.proto'
end
