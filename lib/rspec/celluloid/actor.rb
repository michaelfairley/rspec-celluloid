require 'celluloid'

Celluloid.logger.level = Logger::INFO

module RSpec
  module Celluloid
    class Actor
      include ::Celluloid

      def run(group, reporter)
        group.run(reporter)
      end
    end
  end
end
