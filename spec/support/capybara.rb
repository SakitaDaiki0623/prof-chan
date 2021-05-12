# spec/support/capybara.rb
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :chrome, screen_size: [1500, 1080]
  end
end
