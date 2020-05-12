require 'rails_helper'

describe Api::Talkpush do

  describe '#initialize' do
    it 'sets the variables' do
      talkpush = described_class.new
      variables = talkpush.instance_variables

      expect(variables.size).to eq(4)
      expect(variables).to include(:@talkpush_url)
      expect(variables).to include(:@talkpush_api_key)
      expect(variables).to include(:@talkpush_api_secret)
      expect(variables).to include(:@talkpush_campaign_id)
    end
  end

end