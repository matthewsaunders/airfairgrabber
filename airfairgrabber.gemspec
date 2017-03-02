Gem::Specification.new do |s|
  s.name        = 'airfairgrabber'
  s.version     = '0.0.0'
  s.date        = '2017-02-24'
  s.summary     = "AirFair Grabber"
  s.description = "A gem to grab airfares"
  s.authors     = ["Matthew Saunders"]
  s.email       = 'matthew.saunders12@gmail.com'
  s.files       = [
    "lib/airfairgrabber.rb",
    "lib/collector/factory.rb",
    "lib/collector/collector.rb",
    "lib/collector/google_collector.rb",
    "lib/processor/factory.rb",
    "lib/processor/processor.rb",
    "lib/processor/google_processor.rb",
  ]
  s.homepage    =
    'http://rubygems.org/gems/airfairgrabber'
  s.license       = 'MIT'

  s.add_runtime_dependency("capybara", "= 2.12.0")
  s.add_runtime_dependency("nokogiri", "= 1.7.0.1")
  s.add_runtime_dependency("poltergeist", "= 1.13.0")
end
