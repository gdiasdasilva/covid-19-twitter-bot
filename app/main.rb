# frozen_string_literal: true

require_relative "./fetch_data_service.rb"
require_relative "./tweet_service.rb"

data_for_today = FetchDataService.new.call
return if data_for_today.nil?

TweetService.new(data: data_for_today).call
