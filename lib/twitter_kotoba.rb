require_relative 'twitter_kotoba/twitter_connection'

class TwitterKotoba

  attr_accessor :user
  attr_reader :latest_tweets
  attr_reader :sorted_words
  attr_reader :rate_limit_exceeded

  def initialize(user)
    @user = user
    @latest_tweets = []
    @sorted_words = []
    @rate_limit_exceeded = false
  end

  def word_list
    if update
      word_hash = sanitized_tweets
      @sorted_words = word_hash.sort_by{ |key,value| value }
      output_words
    elsif @rate_limit_exceeded
      puts "\nTwitter rate limit exceeded.\n"
      # Twitter's limit is 150 req/hr so...
      # you can only make 150/5 = 30 req/hr
      puts "You may only make 30 requests per hour.\n\n"
    end

    return nil
  end

  private

  def update
    # query the twitter api
    twitter_connection = TwitterConnection.new(@user)
    # store latest 1000 tweets in @latest_tweets
    # latest_1000 = twitter_connection.get_latest_1000
    @latest_tweets = twitter_connection.get_latest_1000
    unless @latest_tweets.empty?
      return true
    else
      @rate_limit_exceeded = true if twitter_connection.rate_limit_exceeded
      return false
    end
  end

  def sanitized_tweets
    # make a hash that defaults to 0 to store words with their frequency
      word_hash = Hash.new(0)
      @latest_tweets.each do |tweet|
        # remove non-word characters from tweet and make it an array of words
        begin
          sanitized_tweet = tweet['text'].gsub(/(\W|\d)+/," ").split(" ")
          sanitized_tweet.each_with_object(word_hash){ |word,hash| hash[word] += 1}
        rescue
          # some weird things in tweets cause errors
          # you should log these
        end
      end
      return word_hash
  end

  def output_words
    # In an effort not to overwhelm the shell's scrollback history
    # I'm only outputting the top 500 words
    @sorted_words.length < 500 ? from = 0 : from = @sorted_words.length - 500
   
    @sorted_words[from..-1].each do |w|
      puts "#{w[1].to_s.rjust(4)}: #{w[0]}"
    end

    unless from == 0
      puts "\nThis is the top 500 words.\n"
      puts "Call \"sorted_words\" for the entire list.\n"
    end
  end

end