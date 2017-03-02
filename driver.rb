require 'awesome_print'

require_relative './lib/airfairgrabber.rb'

date = Date.today + 21 # add 3 weeks
trips = Google.collect_one_way("BOS", "MIA", date)

ap trips
