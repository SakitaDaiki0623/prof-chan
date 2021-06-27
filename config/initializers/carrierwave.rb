require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  config.storage :fog unless Rails.env.test?
  config.fog_provider = 'fog/aws' unless Rails.env.test?
  config.fog_directory  = 'prof-chan-carriwave' unless Rails.env.test?
  config.enable_processing = false if Rails.env.test?
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: ENV['AWS_DEFAULT_REGION'],
    path_style: true
  }

end