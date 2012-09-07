require 'minitest/autorun'
require 'minitest/pride'
require 'turn'
require 'mocha'
require 'twitter_kotoba/twitter_connection'

Turn.config.format = :outline



describe TwitterConnection do

  before do
    @twitter_connection = TwitterConnection.new('square')
  end

  describe "making requests" do
    it "should return a requests array with 5 requests" do
      Typhoeus::Hydra.any_instance.stubs(:run).returns([])
      requests = @twitter_connection.make_requests
      requests.length.must_equal 5
    end
    it "should have Typhoeus::Request objects in the requests array" do
      Typhoeus::Hydra.any_instance.stubs(:run).returns([])
      requests = @twitter_connection.make_requests
      requests[0].class.must_equal Typhoeus::Request
    end
  end

  describe "processing requests" do
    it "will return an array" do
      Typhoeus::Hydra.any_instance.stubs(:run).returns([])
      Oj.stubs(:load).returns([])

      mock_response = mock
      mock_response.stubs(:code).returns(200)
      mock_response.stubs(:body).returns("")
      Typhoeus::Request.any_instance.stubs(:response).returns(mock_response)

      requests = @twitter_connection.make_requests
      tweets = @twitter_connection.process_requests(requests)

      tweets.class.must_equal Array
    end
    it "will set the rate limit to true if any request returned 400" do
      Typhoeus::Hydra.any_instance.stubs(:run).returns([])
      Oj.stubs(:load).returns([])

      mock_response = mock
      mock_response.stubs(:code).returns(400)
      mock_response.stubs(:body).returns("")
      Typhoeus::Request.any_instance.stubs(:response).returns(mock_response)

      requests = @twitter_connection.make_requests
      tweets = @twitter_connection.process_requests(requests)

      @twitter_connection.rate_limit_exceeded.must_equal true
    end
    it "will return an empty tweets array if all requests returned 400" do
      Typhoeus::Hydra.any_instance.stubs(:run).returns([])
      Oj.stubs(:load).returns([])

      mock_response = mock
      mock_response.stubs(:code).returns(400)
      mock_response.stubs(:body).returns("")
      Typhoeus::Request.any_instance.stubs(:response).returns(mock_response)

      requests = @twitter_connection.make_requests
      tweets = @twitter_connection.process_requests(requests)

      assert_equal [], tweets
    end
  end

  describe "checking rate limit" do
    it "should initially be false" do
      @twitter_connection.rate_limit_exceeded.must_equal false
    end
  end

end