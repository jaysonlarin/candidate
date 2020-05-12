class GoogleSheetCandidate
  attr_accessor :candidates

  def initialize
    @google_sheet_id = ENV['GOOGLE_SHEET_ID']
    @google_credential = "./config/google_credentials.json"
  end

  def persist
    get_candidates.present?
  end

  def get_candidates
    return "Error in getting spreadsheet" if self.spreadsheet_rows.class.eql?(Google::Apis::ClientError)
    @candidates = self.spreadsheet_rows.worksheets[0].rows.select{|x| x[0] != 'Timestamp'}
  end

  def spreadsheet_rows
    return "Error in initializing google session" if self.google_session.class.eql?(ArgumentError)
    self.google_session.spreadsheet_by_key(@google_sheet_id)
  end

  def google_session
    GoogleDrive::Session.from_config(@google_credential)
  end
end