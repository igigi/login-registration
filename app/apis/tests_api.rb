class TestsApi < BaseApi

  get '/a' do
    "Hello world A"
  end

  get '/b' do
    "Hello world B"
  end
end