require "ruboty/elb_monitor/version"
require "ruboty/elb_monitor/aws"
require "ruboty/handlers/elb_monitor"

module Ruboty
  module ElbMonitor
    NAMESPACE = "elb_monitor"

    class << self
      def elb(name)
        Aws::Elb.new(name, sdk_options)
      end

      def cloudwatch(elb_name, start_time=nil, end_time=nil)
        options = sdk_options.merge(
          start_time: start_time,
          end_time:   end_time,
        )
        Aws::CloudWatch.new(elb_name, options)
      end

      def metrics
        (ENV["ELB_METRICS"] || DEFAULT_METRICS).split(/,/)
      end

      def trend_separator
        ENV["ELB_TREND_SEPARATOR"] || ' '
      end

      private
      DEFAULT_METRICS = %w{
        RequestCount
        HealthyHostCount
        UnHealthyHostCount
        HTTPCode_ELB_4XX
        HTTPCode_ELB_5XX
        HTTPCode_Backend_2XX
        HTTPCode_Backend_4XX
        HTTPCode_Backend_5XX
        BackendConnectionErrors
        SurgeQueueLength
        SpilloverCount
        Latency
      }.join(",")

      def sdk_options
        options = {
          http_proxy: ENV["HTTPS_PROXY"] || ENV["https_proxy"] || ENV["HTTP_PROXY"] || ENV["http_proxy"]
        }
        options[:region]            = ENV["ELB_REGION"]            if ENV["ELB_REGION"]
        options[:access_key_id]     = ENV["ELB_ACCESS_KEY_ID"]     if ENV["ELB_ACCESS_KEY_ID"]
        options[:secret_access_key] = ENV["ELB_SECRET_ACCESS_KEY"] if ENV["ELB_SECRET_ACCESS_KEY"]
        options
      end
    end
  end
end
