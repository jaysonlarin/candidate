require 'rails_helper'

describe GoogleSheetCandidate do

  describe '#initialize' do
    it 'sets the variables' do
      google_sheet_candidate = described_class.new
      variables = google_sheet_candidate.instance_variables

      expect(variables.size).to eq(2)
      expect(variables).to include(:@google_sheet_id)
      expect(variables).to include(:@google_credential)
    end
  end

  describe '#get_candidates' do
    it 'returns candidates' do
      VCR.use_cassette('GoogleSheet Candidates', record: :once) do
        candidates = GoogleSheetCandidate.new.get_candidates

        expect(candidates[0].size).to eq 5
        expect(candidates.class).to eq Array
      end
    end
  end

end