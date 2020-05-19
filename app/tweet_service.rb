require "twitter"
require "dotenv"

Dotenv.load

# Tweet the most recent COVID data
class TweetService
  def initialize(data:)
    @data = data
  end

  def call
    post_to_twitter
  end

  private

  def message
    "🦠 Actualização // #{@data[:date]} 🦠\n\n" \
    "😷 Casos confirmados: #{@data[:confirmed]} (+#{@data[:confirmed_new]} " \
      "que no dia anterior)\n" \
    "💪 Casos recuperados: #{@data[:recovered]}\n" \
    "🏥 Internados em UCI: #{@data[:interned_icu].to_i}\n" \
    "⚰️  Óbitos: #{@data[:deaths]}\n\n" \
    "#COVID19PT #COVID"
  end

  def post_to_twitter
    twitter_client.update(message)
  end

  def twitter_client
    @twitter_client ||= begin
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_API_KEY"]
        config.consumer_secret     = ENV["TWITTER_API_SECRET_KEY"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end
    end
  end
end
