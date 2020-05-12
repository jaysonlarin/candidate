require 'rails_helper'

describe Api::Talkpush::CreateCandidate do
  let(:candidate_one) { ["10/12/2019 12:31:45", "John", "Lennon", "jlennon@mail.com", "123"] }
  let(:service) { described_class.new(candidate_one) }
  let(:talkpush) { Api::Talkpush.new }
  let(:request_url) {
    "#{talkpush.talkpush_url}/campaigns/"\
    "#{talkpush.talkpush_campaign_id}/"\
    "campaign_invitations"
  }

  describe '#initialize' do
    it 'sets the variables' do
      variables = service.instance_variables

      expect(variables.size).to eq(2)
      expect(variables).to include(:@talkpush)
      expect(variables).to include(:@candidate)
    end
  end

  describe '#request_url' do
    it 'returns the expected url for creating a candidate' do
      expect(service.request_url).to eq request_url
    end
  end

  describe '#create_candidate' do
    it 'creates candidate one in Talkpush' do
      VCR.use_cassette('Create Candidate One', record: :once) do
        response = service.create_candidate

        expect(response.body).to include('Candidate was succesfully added to the campaign')
        expect(response.status).to eq 200

        parsed_response = JSON.parse(response.body)
        expect(parsed_response.keys).to eql ["message", "url", "pin", "id"]
        expect(parsed_response['message']).to eql "Candidate was succesfully added to the campaign."
        expect(parsed_response['url']).to eql "https://my.talkpush.com/guests/campaign_invitations/944639/outbound_call?company_id=16&outbound_token=46b70ef96d4b00c438c4886c18070193e186a82f1d2903965ec33e497b2eaaa1&source=MICROSITE"
        expect(parsed_response['pin']).to eql '206058'
        expect(parsed_response['id']).to eql 944639
      end
    end
  end
end