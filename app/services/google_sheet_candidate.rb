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
    return "Error in getting spreadsheet" if spreadsheet_rows.class.eql?(Google::Apis::ClientError)
    @candidates = spreadsheet_rows.worksheets[0].rows.select{|x| x[0] != 'Timestamp'}
  rescue
    return []
  end

  def spreadsheet_rows
    return "Error in initializing google session" if google_session.class.eql?(ArgumentError)
    google_session.spreadsheet_by_key(@google_sheet_id)
  rescue => e
    return e
  end

  def google_session
    GoogleDrive::Session.from_config(@google_credential)
  rescue => e
    return e
  end
end