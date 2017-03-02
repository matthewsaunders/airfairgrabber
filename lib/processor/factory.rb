require_relative './google_processor'

module AirFair
  module Processors

    class Factory
      def self.google_processor
        GoogleProcessor.new
      end
    end

  end
end
