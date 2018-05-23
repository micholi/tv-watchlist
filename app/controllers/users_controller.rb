class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/shows'
    else
      erb :'/users/login'
    end
  end

  post '/login' do

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
