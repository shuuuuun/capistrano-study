require "sinatra/base"

class App < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  set :bind, "0.0.0.0"
  set :port, ENV["PORT"] || 4567
  set :protection, true
  set :sessions, true
  set :inline_templates, true

  get "/" do
    "hello"
  end

  get "/ping" do
    "pong"
  end

  # run! if app_file == $0
end
