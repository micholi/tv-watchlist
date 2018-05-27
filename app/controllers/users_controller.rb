class UsersController < ApplicationController

  get '/users' do
    user_check
    @users = User.all
    erb :'/users/users'
  end

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
      flash[:message] = "Invalid username or password! Please try again."
      redirect '/login'
    end
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    if params[:email].empty? || params[:username].empty? || params[:password].empty?
      flash[:message] = "Please fill out all fields to continue."
      redirect '/signup'
    elsif User.find_by(email: params[:email])
      flash[:message] = "Sorry, that email is already in use. Please try a different one."
      redirect '/signup'
    elsif User.find_by(username: params[:username])
      flash[:message] = "Sorry, that username is already in use. Please try a different one."
    else
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      session[:user_id] = @user.id
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
