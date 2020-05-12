# README

### Setup google credentials
- Create application in [Google Developer Console](https://console.developers.google.com)
- Enable the Drive API and Sheet API
- Download the Google API credential json file
- Save the json file in the `config/google_credentials.json`

### Setup ENV variables in the config/application.yml
```ruby
  GOOGLE_SHEET_ID: ''

  TALKPUSH_URL: 'https://my.talkpush.com/api/talkpush_services'
  TALKPUSH_API_KEY: ''
  TALKPUSH_API_SECRET: ''
  TALKPUSH_CAMPAIGN_ID: ''
```

### Retrieve google sheet candidates
```ruby
  service = GoogleSheetCandidate.new
  service.get_candidates
```

### Retrieve existing candidates
```ruby
  talkpush_service = Api::Talkpush::ExistingCandidates.new
  existing_candidates = talkpush_service.existing_candidates['candidates']
```

### Create talkpush candidate
```ruby
  candidate = ["10/12/2019 12:31:45", "John", "Lennon", "jlennon@mail.com", "123"]
  Api::Talkpush::CreateCandidate.candidate(candidate)
```

# Schedule sync of candidates via activejob
```ruby
  every 10.minutes do
    runner "CandidateJob.perform_later"
  end
```