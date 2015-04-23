require 'headless'
require 'selenium-webdriver'

# In these tests I use different display numbers to avoid
describe 'Integration test' do
  before do
    @headless = Headless.new
    @headless.start
  end

  after do
    @headless.destroy
  end

  it 'should use xvfb' do
    work_with_browser
  end

  it 'should record screenshots' do
    headless.take_screenshot("test.jpg")
    expect(File.exist?("test.jpg")).to eq true
  end

  it 'should record video with ffmpeg' do
    headless.video.start_capture
    work_with_browser
    headless.video.stop_and_save("test.mov")
    expect(File.exist?("test.mov")).to eq true
  end

  def work_with_browser
    driver = Selenium::WebDriver.for :firefox
    driver.navigate.to 'http://google.com'
    expect(driver.title).to match(/Google/)
    driver.close
  end
end
