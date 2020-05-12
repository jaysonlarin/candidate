class Api::Talkpush
  attr_reader :talkpush_url, :talkpush_api_key, :talkpush_api_secret, :talkpush_campaign_id

  def initialize
    @talkpush_url = ENV['TALKPUSH_URL']
    @talkpush_api_key = ENV['TALKPUSH_API_KEY']
    @talkpush_api_secret = ENV['TALKPUSH_API_SECRET']
    @talkpush_campaign_id = ENV['TALKPUSH_CAMPAIGN_ID']
  end
end