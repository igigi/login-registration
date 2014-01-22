require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../app/apis/sessions_api.rb', __FILE__

describe "Sessions" do

  def app
    SessionsApi.new
  end

  it "should be signin" do
    post '/captcha', phone: '13800138000'
    captcha = JSON.parse(last_response.body)['content']
    post '/signin', phone: '13800138000', captcha: captcha
    JSON.parse(last_response.body)['content'].length.should eq(32)
  end
end