class UsersController < ApplicationController

get '/login' do
  # code here
  erb :'/users/login'
end

get '/signup' do
  # code here
  erb :'/users/signup'
end

end
