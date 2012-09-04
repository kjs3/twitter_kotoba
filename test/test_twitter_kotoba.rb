require 'minitest/autorun'
require 'twitter_kotoba'

describe TwitterKotoba do

  before do
    @twitter_kotoba = TwitterKotoba.new('square')
  end

  describe "getting current user" do
    it "should return the same user as when created" do
      @twitter_kotoba.user.must_equal "square"
    end
  end

  describe "changing the user" do
    it "accepts string input" do
      @twitter_kotoba.user = "jack"
      @twitter_kotoba.user.must_equal "jack"
    end
  end

end