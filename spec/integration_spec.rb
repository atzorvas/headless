require 'headless'
require 'selenium-webdriver'

describe 'Integration test' do
  it 'should start xvfb' do
    Headless.ly(display: 999) do
      driver = Selenium::WebDriver.for :firefox
      driver.navigate.to 'http://google.com'
      expect(driver.title).to match /Google/
      driver.close
    end
  end

  it 'should record screenshots' do
    Headless.ly(display: 999) do |headless|
      driver = Selenium::WebDriver.for :firefox
      driver.navigate.to 'http://google.com'
      expect(driver.title).to match /Google/
      headless.take_screenshot("test.jpg")
      driver.close
      expect(File.exists?("test.jpg")).to eq true
    end
  end

  it 'should record video with ffmpeg' do
    Headless.ly(display: 999, video: {provider: :ffmpeg}) do |headless|
      headless.video.start_capture
      driver = Selenium::WebDriver.for :firefox
      driver.navigate.to 'http://google.com'
      expect(driver.title).to match /Google/
      driver.close
      headless.video.stop_and_save("test.mov")
      expect(File.exists?("test.mov")).to eq true
    end
  end
end
