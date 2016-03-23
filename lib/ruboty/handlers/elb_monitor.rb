require "ruboty/elb_monitor/actions/add"
require "ruboty/elb_monitor/actions/delete"
require "ruboty/elb_monitor/actions/list"
require "ruboty/elb_monitor/actions/state"
require "ruboty/elb_monitor/actions/state_trend"

module Ruboty
  module Handlers
    # Monitor AWS ELB via Ruboty.
    class ElbMonitor < Base
      on /add elb (?<name>.+) (?<real_name>.+)/, name: 'add', description: 'Add a new alias name of elb to monitor.'
      on /delete elb (?<name>.+)/, name: 'delete', description: 'Delete a alias name of elb to monitor.'
      on /list elb names\z/, name: 'list', description: 'List all elb names.'
      on /show elb state last (?<time>\d+)(?<format>(w|d|h|m))\z/, name: 'state', description: 'Show all elb status of the last [w]eeks, [d]ays, [h]ours or [m]inutes.'
      on /show elb state (?<from>(?:(?!last).)+) (?<to>.+)/, name: 'state', description: 'Show all elb status of the specified period.'
      on /show elb state last (?<time>\d+)(?<format>(w|d|h|m)) trend\z/, name: 'state_trend', description: 'Show all elb status with trend of the last [w]eeks, [d]ays, [h]ours or [m]inutes.'

      env :ELB_REGION, "AWS region for ELB.", optional: true
      env :ELB_ACCESS_KEY_ID, "AWS access key for ELB.", optional: true
      env :ELB_SECRET_ACCESS_KEY, "AWS secret key for ELB.", optional: true
      env :ELB_METRICS, "Metric list to monitor.", optional: true

      def add(message)
        Ruboty::ElbMonitor::Actions::Add.new(message).call
      end

      def delete(message)
        Ruboty::ElbMonitor::Actions::Delete.new(message).call
      end

      def list(message)
        Ruboty::ElbMonitor::Actions::List.new(message).call
      end

      def state(message)
        Ruboty::ElbMonitor::Actions::State.new(message).call
      end

      def state_trend(message)
        Ruboty::ElbMonitor::Actions::StateTrend.new(message).call
      end
    end
  end
end
