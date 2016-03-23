require_relative "base"

module Ruboty
  module ElbMonitor
    module Actions
      class List < Base
        def call
          message.reply(list)
        rescue => e
          message.reply(e.message)
        end

        private
        def list
          if elbs.empty?
            "ELB not found"
          else
            elbs.map{|k, v| "#{k}: #{v}"}.join("\n")
          end
        end
      end
    end
  end
end
