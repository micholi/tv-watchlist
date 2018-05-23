class UsersController < ApplicationController

  get '/login' do
    if logged_in?
      redirect '/shows'
    else
      erb :'/users/login'
    end
  end

  get '/signup' do
    # code here
    erb :'/users/signup'
  end

end
