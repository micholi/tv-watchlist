class ShowsController < ApplicationController

  get '/shows' do
    @shows = Show.all
    erb :'/shows/index'
  end

  get '/shows/new' do
    # code here
    erb :'/shows/new'
  end

end
