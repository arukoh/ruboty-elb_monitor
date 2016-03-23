module Ruboty
  module ElbMonitor
    module Actions
      class Base < Ruboty::Actions::Base
        private
        def elbs
          message.robot.brain.data[Ruboty::ElbMonitor::NAMESPACE] ||= {}
        end
      end
    end
  end
end
