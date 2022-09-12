Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,1400')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

# Setup rspec
RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :chrome_headless
  end
end

# Capybara.register_driver :chrome_headless do |app|
#   options = ::Selenium::WebDriver::Chrome::Options.new

#   options.add_argument('--headless')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')
#   options.add_argument('--window-size=1400,1400')

#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

# Capybara.javascript_driver = :chrome_headless

# RSpec.configure do |config|
#   config.before(:each, type: :system) do
#     driven_by :rack_test
#   end

#   config.before(:each, type: :system, js: true) do
#     if ENV["SELENIUM_DRIVER_URL"].present?
#       driven_by :selenium, using: :chrome, options: {
#         browser: :remote,
#         url: ENV.fetch("SELENIUM_DRIVER_URL"),
#         desired_capabilities: :chrome
#       }
#     else
#       driven_by :selenium_chrome_headless
#     end
#   end
# end
# Capybaraに、remote_chromeという名前のdriverを登録する

# Capybara.register_driver :selenium do |app|
#   if ENV['CIRCLECI']
#     options = Selenium::WebDriver::Chrome::Options.new
#     options.add_argument('--headless')
#     options.add_argument('--no-sandbox')
#     options.add_argument('--disable-dev-shm-usage')
#     options.add_argument('--window-size=1400,1400')
#     Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
#   else
#     capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#       chromeOptions: {
#         prefs: {
#           'download.default_directory' => DownloadHelper::PATH.to_s
#         },
#         args: [
#           '--headless',
#           '--window-size=1400,1400',
#           '--no-sandbox',
#           '--disable-dev-shm-usage',
#           '--lang=ja-JP',
#         ],
#       }
#     )
#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :remote, 
#       url: 'http://chromium:4444/wd/hub',
#       desired_capabilities: capabilities,
#     )
#   end
# end

# config.before(:each, type: :feature, js: true, driver: :selenium) do
#   Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
#   Capybara.server_port = 4444
#   Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
#   if ENV['CIRCLECI']
#     page.driver.browser.download_path = DownloadHelper::PATH.to_s
#   end
# end