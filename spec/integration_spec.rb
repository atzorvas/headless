require 'headless'
require 'selenium-webdriver'

describe 'Integration test' do
  it 'should start xvfb' do
    Headless.ly do
      work_with_browser
    end
  end

  it 'should record screenshots' do
    Headless.ly do |headless|
      headless.take_screenshot("test.jpg")
      expect(File.exists?("test.jpg")).to eq true
    end
  end

  it 'should record video with ffmpeg' do
    Headless.ly(video: {log_file_path: STDERR}) do |headless|
      headless.video.start_capture
      work_with_browser
      headless.video.stop_and_save("test.mov")
      expect(File.exists?("test.mov")).to eq true
    end
  end

  def work_with_browser
    driver = Selenium::WebDriver.for :firefox
    driver.navigate.to 'http://google.com'
    expect(driver.title).to match /Google/
    driver.close
  end
end
