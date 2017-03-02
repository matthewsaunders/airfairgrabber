require 'date'

require_relative './collector/factory'
require_relative './processor/factory'

class Airfairgrabber
  def self.test
    puts "AirFair Grabber v0.0.0"
  end
end

class BaseDriver
  def self.validate_airport(airport)
    raise ArgumentError, "Invalid airport code: #{airport}" unless /^[a-zA-Z]{3}$/.match(airport)
  end

  def self.validate_date(date)
    raise ArgumentError, "Invalid travel date: #{date}" unless date.instance_of?(Date)
  end
end

class Google < BaseDriver
  def self.collect_one_way(from, to, date)
    # Validate
    validate_airport(from)
    validate_airport(to)
    validate_date(date)

    # Arrange
    collector = AirFair::Collectors::Factory.google_collector()
    processor = AirFair::Processors::Factory.google_processor()

    # Run
    raw_data = collector.fetch(from, to, date)
    trips = processor.parse(raw_data)
  end
end
