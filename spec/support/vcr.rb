VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true

  [
    { param: 'apikey', value: 'omdb_api_key' }
  ].each do |hash|
    config.filter_sensitive_data(hash[:param]) { Rails.application.credentials.public_send(hash[:value]) }
  end
end
