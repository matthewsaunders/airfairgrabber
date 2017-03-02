require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'nokogiri'

include Capybara::DSL

module AirFair
  module Collectors

    class Collector
      @@SLEEP_DURATION = 0.2
      @@MAX_TRIES = 20

      @browser = nil

      def initialize
        initialize_capybara()
      end

      def initialize_capybara
        Capybara.register_driver :poltergeist do |app|
          Capybara::Poltergeist::Driver.new(app, js_errors: false)
        end

        Capybara.default_driver = :poltergeist
        @browser = Capybara.current_session
      end

      def validate_page_load_by_element(elem)
        tries = 0
        has_elem = @browser.has_selector?(elem)

        while(!has_elem && tries < @@MAX_TRIES)
          sleep(@@SLEEP_DURATION)
          tries += 1
          has_elem = @browser.has_selector?(elem)
        end
      end

      def validate_page_load_by_element_content(elem, content)
        return false if !@browser.has_selector?(elem)

        tries = 0
        has_content = @browser.find(elem).text.include? content

        while(!has_content && tries < @@MAX_TRIES)
          sleep(@@SLEEP_DURATION)
          tries += 1
          has_content = @browser.find(elem).text.include? content
        end
      end
    end

  end
end
