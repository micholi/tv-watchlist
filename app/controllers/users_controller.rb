class UsersController < ApplicationController

  use Rack::Flash

  get '/login' do
    if logged_in?
      redirect '/shows'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/shows'
    else
      flash[:message] = "Error!"
      redirect to "/login"
    #erb :'/users/login'
    end
  end

  get '/signup' do

    erb :'/users/signup'
  end

  post '/signup' do
    if params[:email].empty? || params[:username].empty? || params[:password].empty?
      flash[:message] = "Please fill out all fields to continue."
      redirect to '/signup'
      #redirect '/signup', flash[:message] = "Please fill out all fields to continue."
    elsif User.find_by(email: params[:email])
      flash[:message] = "Sorry, that email address is already in use."
      redirect '/signup'
    else

      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
      # flash message?
      redirect '/shows'

    end
  end




  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

end
