task default: %w[server]

task :generate_proto do
  sh 'grpc_tools_ruby_protoc -I client/src/protos --ruby_out=server/lib --grpc_out=server/lib client/src/protos/discount_calculator.proto'
end
