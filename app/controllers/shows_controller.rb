class ShowsController < ApplicationController

  get '/shows' do
    # code here
    erb :'/shows/index'
  end

  get '/shows/new' do
    # code here
    erb :'/shows/new'
  end

end
