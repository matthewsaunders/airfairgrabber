require_relative './google_collector'

module AirFair
  module Collectors

    class Factory
      def self.google_collector
        GoogleCollector.new
      end
    end

  end
end
