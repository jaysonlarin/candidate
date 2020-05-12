class CandidateJob < ApplicationJob
  queue_as :default

  attr_accessor :google_sheet_candidates, :existing_candidates, :filtered_candidates

  def perform
    self.persist
    filtered_candidates.each do |candidate|
      CreateCandidateJob.perform_now(candidate)
    end
  rescue => e
    # log error occurred
    logger.debug("Debug Info: Something Went Wrong")
    logger.debug("Debug Info: #{e.message}")
  end

  def persist
    self.enlisted_google_sheet_candidates &&
    self.enlisted_talkpush_candidates &&
    self.filter_candidates.present?
  end

  def enlisted_talkpush_candidates
    talkpush_service = Api::Talkpush::ExistingCandidates.new
    @existing_candidates = talkpush_service.existing_candidates['candidates']
    @existing_candidates =
      @existing_candidates
        .pluck('first_name', 'last_name', 'email', 'user_phone_number')

    return true
  end

  def enlisted_google_sheet_candidates
    google_sheet_service = GoogleSheetCandidate.new
    return unless google_sheet_service.persist
    @google_sheet_candidates = google_sheet_service.candidates

    @google_sheet_candidates.present?
  end

  def filter_candidates
    existing_candidates_email = existing_candidates.pluck(2)
    @filtered_candidates =
      google_sheet_candidates.reject{ |v|
        existing_candidates_email.include?(v[3])
      }

    @filtered_candidates
  end
end