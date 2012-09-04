require 'minitest/autorun'
require 'twitter_kotoba/twitter_connection'

describe TwitterConnection do

  before do
    @twitter_connection = TwitterConnection.new('square')
  end

  describe "checking rate limit" do
    it "should initially be false" do
      @twitter_connection.rate_limit_exceeded.must_equal false
    end
  end

  describe "building requests" do
    it "should return an array of 5 requests" do
      requests = @twitter_connection.run_requests
      requests.length.must_equal 5
    end
  end

  describe "processing requests" do
    it "" do
    end
  end

end