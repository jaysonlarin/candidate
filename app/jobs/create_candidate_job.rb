class CreateCandidateJob < ApplicationJob
  queue_as :default

  def perform(candidate)
    begin
      service = Api::Talkpush::CreateCandidate.new(candidate)
      service.persist
    rescue => e
      logger.debug("Debug Info: #{e}")
    end
  end
end