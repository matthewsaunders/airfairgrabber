require_relative './collector'
require_relative '../processor/google_processor'

module AirFair
  module Collectors

    class GoogleCollector < Collector
      @@DIV = {
        SHOW_ALL_FLIGHTS: ".OMOBOQD-d-c",
        TRIP_SUMMARY: ".OMOBOQD-l-a",
        TRIP_INFO: ".OMOBOQD-Zb-h",
      }

      @page = nil

      def initialize
        super
      end

      def fetch(to, from, date)
        # Visit main page listing all flights
        @browser.visit url(to, from, date)
        validate_page_load_by_element(@@DIV[:SHOW_ALL_FLIGHTS])

        # Collect all the flight detail links for the specifics of each trip
        document = Nokogiri::HTML(@browser.body)
        trip_links = document.css("div.OMOBOQD-d-W.OMOBOQD-d-Lb.OMOBOQD-d-S a").map{ |trip| trip["href"] }

        # Uncomment to only collect 2 flights when testing/debugging
        #
        # tmp = trip_links
        # trip_links = [
        #   trip_links[0],
        #   trip_links[1],
        # ]

        trip_records = []
        trip_links.each do |link|
          # Load trip page
          @browser.visit link
          validate_page_load_by_element(@@DIV[:TRIP_INFO])

          # Grab trip info section
          page = Nokogiri::HTML(@browser.body)
          trip_records << page.css(@@DIV[:TRIP_SUMMARY]).to_s
        end

        trip_records
      end

      def url(from, to, date)
        "https://www.google.com/flights/#search;f=#{from};t=#{to};d=#{date.year}-#{date.mon}-#{date.mday};tt=o;eo=e"
      end
    end

  end
end
