require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "supersecret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
        User.find_by_id(session[:user_id])
      end
    end

    def user_check
      if logged_in?
        @user = current_user
      else
        flash[:message] = "Please log in or sign up to continue."
        redirect '/'
      end
    end
  end

end
