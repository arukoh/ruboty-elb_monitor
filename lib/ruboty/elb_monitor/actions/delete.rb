require_relative "base"

module Ruboty
  module ElbMonitor
    module Actions
      class Delete < Base
        def call
          message.reply(delete)
        rescue => e
          message.reply(e.message)
        end

        private
        def delete
          name = message[:name]
          if elbs.has_key?(name)
            elbs.delete(name)
            "ELB #{name} deleted"
          else
            "ELB #{name} does not exist"
          end
        end
      end
    end
  end
end
