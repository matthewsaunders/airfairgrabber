require_relative './processor'

module AirFair
  module Processors

    class GoogleProcessor < Processor
      @@DIVS = {
        FLIGHT_ROW: ".OMOBOQD-d-eb",
        FLIGHT_ROW_SKIP: ".OMOBOQD-d-ib",

        MIDDLE_SECTION: ".OMOBOQD-d-fb",
        RIGHT_SECTION: ".OMOBOQD-d-gb",

        DATETIMES: ".OMOBOQD-d-Zb",
        AIRPORTS: ".OMOBOQD-d-Kb",
        AIRPLANE_INFO: ".OMOBOQD-d-N",
        OPERATOR: ".OMOBOQD-d-C",
        COST: ".OMOBOQD-x-z",
      }

      def initialize
        super
      end

      def parse(records = [])
        trips = []

        records.each do |record|
          trip = {
            flights: [],
          }

          # Trip could have multiple flights, so parse each flight
          dom = Nokogiri::HTML(record)
          raw_flights = dom.css(@@DIVS[:FLIGHT_ROW])
          raw_flights.each do |raw_flight|
            next unless raw_flight.css(@@DIVS[:FLIGHT_ROW_SKIP]).empty?

            flight = parse_flight(raw_flight)
            trip[:flights] << parse_flight(raw_flight)
          end

          # Grab the cost
          cost_div = dom.at_css(@@DIVS[:COST])
          if cost_div
            cost = cost_div.text.split[0]
            trip[:cost] = cost[1, cost.length]
          else
            trip[:cost] = nil
          end

          trips << trip
        end

        trips
      end

      private
        def parse_flight(raw_flight)
          flight = {
            departure: {},
            arrival: {},
          }

          # Parse flight details
          middle_section = raw_flight.at_css(@@DIVS[:MIDDLE_SECTION])

          datetimes = middle_section.at_css(@@DIVS[:DATETIMES]).css('span')
          flight[:departure][:datetime] = DateTime.parse(datetimes[0]['tooltip'])
          flight[:arrival][:datetime] = DateTime.parse(datetimes[1]['tooltip'])

          airports = middle_section.at_css(@@DIVS[:AIRPORTS]).text.split('–').map(&:strip)
          flight[:departure][:airport] = airports[0]
          flight[:arrival][:airport] = airports[1]

          airplane_info = middle_section.at_css(@@DIVS[:AIRPLANE_INFO]).text.split('·').map(&:strip)
          flight[:flight_number] = airplane_info[0]
          flight[:seat_class] = airplane_info[1]
          flight[:plane_model] = airplane_info[2]

          operator = middle_section.at_css(@@DIVS[:OPERATOR])
          flight[:operator] = operator.nil? ? nil : operator.text

          # Return flight
          flight
        end

        def parse_datetime(dt)
          tokens = dt.split
        end
    end

  end
end
