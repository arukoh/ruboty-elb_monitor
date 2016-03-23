require_relative "state"

module Ruboty
  module ElbMonitor
    module Actions
      class StateTrend < State
        def call
          message.reply(state(true))
        rescue => e
          message.reply(e.message)
        end
      end
    end
  end
end
