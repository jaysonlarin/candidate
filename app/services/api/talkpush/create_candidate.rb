class Api::Talkpush::CreateCandidate
  attr_reader :talkpush, :candidate

  def initialize(candidate)
    @talkpush = Api::Talkpush.new
    @candidate = candidate
  end

  def persist
    self.candidate &&
    self.talkpush.talkpush_url &&
    self.talkpush.talkpush_campaign_id &&
    self.create_candidate
  end

  def request_url
    "#{self.talkpush.talkpush_url}/campaigns/"\
    "#{self.talkpush.talkpush_campaign_id}/"\
    "campaign_invitations"
  end

  def create_candidate
    connection = Faraday.new(url: request_url) do |conn|
      conn.adapter :net_http
    end

    response = connection.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Cache-Control'] = 'application/json'
      req.body = json_body
    end
  end

  private

  def json_body
    {
      "api_key": self.talkpush.talkpush_api_key,
      "api_secret": self.talkpush.talkpush_api_secret,
      "campaign_invitation": {
        "first_name": candidate[1],
        "last_name": candidate[2],
        "email": candidate[3],
        "user_phone_number": candidate[4]
      }
    }.to_json
  end

end