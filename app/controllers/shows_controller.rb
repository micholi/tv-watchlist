class ShowsController < ApplicationController

  get '/shows' do
    set_user
    @shows = Show.all
    erb :'/shows/index'
  end

  get '/shows/new' do
    set_user
    erb :'/shows/new'
  end

  post '/shows' do
    # validation here
    set_user
    @show = Show.create(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
    network = Network.find_or_create_by(name: params[:network_name])
    @show.network = network
    @show.owner = current_user
    @show.users << current_user
    # user code
    @show.save
    #redirect "/shows/#{@show.id}"
    redirect "/shows/#{@show.slug}"
  end

  get '/shows/:slug' do
    #binding.pry
    set_user
    @show = Show.find_by_slug(params[:slug])
  #  @user = current_user
    erb :'/shows/detail'
    # redirect here
  end

  get '/shows/:slug/edit' do
    set_user
    @show = Show.find_by_slug(params[:slug])
    erb :'/shows/edit'
  end

  patch '/shows/:slug' do
    set_user
    @show = Show.find_by_slug(params[:slug])
    # validity check
    @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
    network = Network.find_or_create_by(name: params[:network_name])
    @show.network_id = network.id
    @show.save
    redirect "/show/#{@show.slug}"
  end

  delete '/show/:id/delete' do
    #set_user
    @show = Show.find_by_id(params[:id])
    if @show && @show.owner == current_user
      @show.delete
    # else needed?
  end

end
