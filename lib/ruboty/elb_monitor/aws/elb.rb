module Ruboty
  module ElbMonitor
    module Aws
      class Elb
        def initialize(name, options)
          @name = name

          opts = options.select {|k, v| CLIENT_OPTIONS.include? k.to_sym }
          @client = ::Aws::ElasticLoadBalancing::Client.new(opts)
        end

        def describe
          @client.describe_load_balancers(load_balancer_names: [@name])
        end

        private
        CLIENT_OPTIONS = [:region, :access_key_id, :secret_access_key ]
      end
    end
  end
end
