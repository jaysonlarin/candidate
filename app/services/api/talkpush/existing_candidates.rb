class Api::Talkpush::ExistingCandidates
  attr_reader :talkpush

  def initialize
    @talkpush = Api::Talkpush.new
  end

  def request_url
    "#{self.talkpush.talkpush_url}/campaign_invitations?"\
    "api_key=#{self.talkpush.talkpush_api_key}&"\
    "api_secret=#{self.talkpush.talkpush_api_secret}&"\
    "filter[campaign_id]=#{self.talkpush.talkpush_campaign_id}"
  end

  def existing_candidates
    connection = Faraday.new(url: request_url) do |conn|
      conn.adapter :net_http
    end

    response = connection.get do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Cache-Control'] = 'application/json'
    end

    JSON.parse(response.body)
  end
end