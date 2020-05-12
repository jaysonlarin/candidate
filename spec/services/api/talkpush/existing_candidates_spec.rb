require 'rails_helper'

describe Api::Talkpush::ExistingCandidates do

  let(:service) { described_class.new }
  let(:talkpush) { Api::Talkpush.new }
  let(:request_url) {
    "#{talkpush.talkpush_url}/campaign_invitations?"\
    "api_key=#{talkpush.talkpush_api_key}&"\
    "api_secret=#{talkpush.talkpush_api_secret}&"\
    "filter[campaign_id]=#{talkpush.talkpush_campaign_id}"
  }

  describe '#initialize' do
    it 'sets the variables' do
      variables = service.instance_variables

      expect(variables.size).to eq(1)
      expect(variables).to include(:@talkpush)
    end
  end

  describe '#request_url' do
    it 'expects the url for listing all campaign candidates' do
      expect(service.request_url).to eq request_url
    end
  end

  describe '#existing_candidates' do
    it 'returns the enlisted candidates in talkpush' do
      VCR.use_cassette('Existing Candidate', record: :once) do
        response = service.existing_candidates

        expect(response.keys.size).to eq 4
        expect(response.keys).to eq ["total", "current_page", "pages", "candidates"]
        expect(response['total']).to eq 1
        expect(response['current_page']).to eq 1
        expect(response['pages']).to eq 1
        expect(response['candidates'].class).to eq Array
        expect(response['candidates'][0].keys.size).to eq 22
        expect(response['candidates'][0]['first_name']).to eq 'Ruel'
        expect(response['candidates'][0]['last_name']).to eq 'Nopal'
        expect(response['candidates'][0]['email']).to eq 'rakethost@gmail.com'
        expect(response['candidates'][0]['user_phone_number']).to eq '2345678911'
        expect(response['candidates'][0].keys).to eq ["state",
                                                      "campaign_id",
                                                      "campaign_ats_external_id",
                                                      "id",
                                                      "candidate_id",
                                                      "first_name",
                                                      "last_name",
                                                      "campaign_title",
                                                      "email",
                                                      "user_phone_number",
                                                      "school_name",
                                                      "education",
                                                      "gender",
                                                      "source",
                                                      "scheduled_at",
                                                      "created_at",
                                                      "links",
                                                      "employment",
                                                      "others",
                                                      "labels",
                                                      "answers",
                                                      "photo"]

      end
    end
  end

end