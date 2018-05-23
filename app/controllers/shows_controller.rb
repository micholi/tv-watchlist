class ShowsController < ApplicationController

  get '/shows' do
    @shows = Show.all
    erb :'/shows/index'
  end

  get '/shows/new' do
    # code here
    erb :'/shows/new'
  end

  post '/shows' do
    # validation here
    @show = Show.create(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
    network = Network.find_or_create_by(name: params[:network_name])
    @show.network_id = network.id
    # user code
    @show.save
    redirect "/shows/#{@show.id}"
  end

end
