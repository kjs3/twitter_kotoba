require 'typhoeus'
require 'oj'

class TwitterConnection

  attr_accessor :user
  attr_reader :rate_limit_exceeded

  def initialize(user)
    @user = user
    @rate_limit_exceeded = false
  end

  def get_latest_1000
    
    requests = run_requests
    tweets = process_requests(requests)

    # if any of the requests return anything but 200 try again

    return tweets.flatten
  end

  def run_requests
    # You can only request 200 tweets per page
    # so we need to get 5 pages for a total of 1000 tweets.
    requests = []

    # The typhoeus hydra will run all its queued requests in parallel.
    # Way faster than using Patron or HTTParty and running 5 requests in series
    twitter_hydra = Typhoeus::Hydra.new

    (0..4).each do |req|
      requests[req] = Typhoeus::Request.new("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#{@user}&count=200&page=#{req+1}")
      requests[req].timeout = 10000 # 10 seconds max
      twitter_hydra.queue requests[req]
    end
    twitter_hydra.run

    return requests
  end

  def process_requests(requests)
    # array to hold all the tweets
    tweets = []

    requests.each do |req|
      unless req.response.code == 400
        begin
          resp = Oj.load(req.response.body) unless req.response.code != 200
        rescue
          # occasionaly the response causes Oj.load problems
          # this needs to be looked at further
        end
        unless !resp || resp.empty?
          tweets << resp
        end
      else
        @rate_limit_exceeded = true
      end
    end
    return tweets
  end

end