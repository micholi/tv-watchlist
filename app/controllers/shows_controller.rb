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
    @show.user_id = current_user.id
    # user code
    @show.save
    #redirect "/shows/#{@show.id}"
    redirect "/shows/#{@show.slug}"
  end

  get '/shows/:slug' do
  #  binding.pry
    # login check
    @show = Show.find_by_slug(params[:slug])
    @user = current_user
    erb :'/shows/detail'
    # redirect here
  end

  get '/shows/:slug/edit' do
    # login check
    @show = Show.find_by_slug(params[:slug])
    erb :'/shows/edit'
  end

  patch '/shows/:slug' do
    # login / user check
    @show = Show.find_by_slug(params[:slug])
    # validity check
    @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
    network = Network.find_or_create_by(name: params[:network_name])
    @show.network_id = network.id
    @show.save
    redirect "/show/#{@show.slug}"
  end

  delete '/show/:id/delete' do
    # login / user check
    @show = Show.find_by_id(params[:id])
    @show.delete
    # redirect here
  end

end
