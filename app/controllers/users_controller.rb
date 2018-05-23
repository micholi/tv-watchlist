class UsersController < ApplicationController

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
      redirect '/login'
    end
  end

  get '/signup' do
    # code here
    erb :'/users/signup'
  end

  post '/signup' do

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
