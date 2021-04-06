require 'webmock/rspec'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr' # カセットを保存するルートディレクトリ
  c.hook_into :webmock # 利用するモックライブラリ（内部ではwebmockを利用しています）
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true # VCRを使わない場所ではHTTP通信を許可する
  c.ignore_hosts 'chromedriver.storage.googleapis.com'
  c.default_cassette_options = {
    record: :new_episodes, # カセットがなければAPIをコールしてそれを記録する
    match_requests_on: [:method, :path, :query, :body], # カセットを引き当てる条件
  }
  c.before_record do |interaction| # カセット保存前の処理の設定
    interaction.response.body.force_encoding 'UTF-8'
    interaction.response.body = JSON.pretty_generate(JSON.parse(interaction.response.body)) if interaction.response.body.present?
  end
  c.filter_sensitive_data('<SLACK CLIENT ID>') { ENV['SLACK_CLIENT_ID'] }
  c.filter_sensitive_data('<SLACK CLIENT SECRET>') { ENV['SLACK_CLIENT_SECRET'] }
  c.filter_sensitive_data('<USER TOKEN>') { ENV['USER_TOKEN'] }
  c.filter_sensitive_data('<BOT_USER_TOKEN>') { ENV['BOT_USER_TOKEN'] }
  c.filter_sensitive_data('<SIGNING SECRET>') { ENV['SIGNING_SECRET'] }
end

