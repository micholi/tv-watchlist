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

  get '/shows/:id' do
    # login check
    @show = Show.find_by_id(params[:id])
    @user = current_user
    erb :'/shows/detail'
    # redirect here
  end

  get '/shows/:id/edit' do
    # login check
    @show = Show.find_by_id(params[:id])
    erb :'/shows/edit'
    # redirect here
  end

  patch '/shows/:id' do
    # login / user check
    @show = Show.find_by_id(params[:id])
    # validity check
    @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
    @show.network_id = network.id
    @show.save
  end

  delete '/show/:id/delete' do
    # login / user check
    @show = Show.find_by_id(params[:id])
    @show.delete
    # redirect here
  end

end
