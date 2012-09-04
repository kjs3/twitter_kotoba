Gem::Specification.new do |s|
  s.name        = 'twitter_kotoba'
  s.version     = '0.1.0'
  s.date        = '2012-09-01'
  s.summary     = "Shows word frequency of a user's last 1000 tweets."
  s.description = "Twitter Kotoba gets a user's last 1000 tweets and prints the frequency of each word in descending order."
  s.authors     = ["Kenny Smith"]
  s.email       = 'kjsthree@gmail.com'
  s.homepage    = 'http://github'

  s.add_runtime_dependency('typhoeus', "~> 0.4")
  s.add_runtime_dependency('oj', "~> 1.3")

  s.files       = %w[
    twitter_kotoba.gemspec
    lib/twitter_kotoba.rb
    lib/twitter_kotoba/twitter_connection.rb
  ]
  
end