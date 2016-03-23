require_relative "base"

module Ruboty
  module ElbMonitor
    module Actions
      class Add < Base
        def call
          message.reply(add)
        rescue => e
          message.reply(e.message)
        end

        private
        def add
          name = message[:name]
          real = message[:real_name]

          elb = Ruboty::ElbMonitor.elb(real)
          elb.describe
          elbs[name] = real

          "ELB #{name} registerd."
        end
      end
    end
  end
end
