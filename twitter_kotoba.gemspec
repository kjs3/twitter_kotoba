Gem::Specification.new do |s|
  s.name        = 'twitter_kotoba'
  s.version     = '0.1.1'
  s.date        = '2012-09-01'
  s.summary     = "Shows word frequency of a user's last 1000 tweets."
  s.description = "Twitter Kotoba gets a user's last 1000 tweets and prints the frequency of each word in descending order."
  s.authors     = ["Kenny Smith"]
  s.email       = 'kjsthree@gmail.com'
  s.homepage    = 'https://github.com/kjs3/twitter_kotoba'

  s.add_dependency('typhoeus', "~> 0.4")
  s.add_dependency('oj', "~> 1.3")

  s.files       = %w[
    twitter_kotoba.gemspec
    lib/twitter_kotoba.rb
    lib/twitter_kotoba/twitter_connection.rb
  ]
  
end