class ShowsController < ApplicationController

  get '/shows' do
    #binding.pry

    @shows = Show.all.order(:name)
    erb :'/shows/index'
  end

  get '/shows/new' do
    if logged_in?
      @user = current_user
      erb :'/shows/new'
    else
      flash[:message] = "You must log in to perform this action!"
      redirect '/login'
  end
  end

  post '/shows' do

    if !Network.find_by(name: params[:network_name]) && params[:other_network].empty?
      flash[:message] = "Please fill out all required fields!"
    elsif params[:name].empty? || params[:genre].empty? || params[:network_name].empty? || params[:description].empty? || params[:air_date].empty?
      flash[:message] = "Please fill out all required fields!"
    else

    @show = Show.create(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])

    if params[:other_network].empty?
      network = Network.find_by(name: params[:network_name])
    elsif !params[:other_network].empty? && !Network.find_by(name: params[:other_network])
      network = Network.create(name: params[:other_network])
      # test this and add flash message?
    end

    @show.network_id = network.id
    @show.owner_id = current_user.id
    @show.users << current_user
    # user code
    @show.save
    redirect "/shows/#{@show.slug}"
  end
  end

  get '/shows/:slug' do

    @show = Show.find_by_slug(params[:slug])
    @user = current_user
    erb :'/shows/detail'
    # redirect here
  end

  get '/shows/:slug/add' do

    @user = current_user
    @show = Show.find_by_slug(params[:slug])
    @user.shows << @show

    redirect "/shows/#{@show.slug}"
  end

  get '/shows/:slug/edit' do

    @show = Show.find_by_slug(params[:slug])
    erb :'/shows/edit'
  end

  patch '/shows/:slug' do
    if !Network.find_by(name: params[:network_name]) && params[:other_network].empty?
      flash[:message] = "Please fill out all required fields!"
    elsif params[:name].empty? || params[:genre].empty? || params[:network_name].empty? || params[:description].empty? || params[:air_date].empty?
      flash[:message] = "Please fill out all required fields!"

    @show = Show.find_by_slug(params[:slug])
    # validity check
    @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])

    if params[:other_network].empty?
      network = Network.find_by(name: params[:network_name])
    elsif !params[:other_network].empty? && !Network.find_by(name: params[:other_network])
      network = Network.create(name: params[:other_network])
      # test this and add flash message?
    end
  end

    @show.network_id = network.id
    @show.save
    redirect "/shows/#{@show.slug}"
  end

  delete '/show/:slug/delete' do
    #set_user
    @show = Show.find_by_id(params[:slug])
    if @show && @show.owner == current_user
      @show.delete
    # else needed?
    end
  end

end
