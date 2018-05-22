# require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :secret_session, "supersecret"
  end

  get '/' do
    erb :index
  end

  helpers do
    # code here
  end

end
