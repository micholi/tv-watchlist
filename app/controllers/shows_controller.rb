class ShowsController < ApplicationController

  get '/shows' do
    binding.pry
    user_check
    @shows = Show.all.order(:name)
    erb :'/shows/index'
  end

  get '/shows/new' do
    user_check
    erb :'/shows/new'
  end

  post '/shows' do
    user_check
    if Show.find_by(name: params[:name])
      flash[:message] = "You may not add a show that already exists!"
      redirect '/shows'
    elsif params[:name].empty? || params[:genre].empty? || (!Network.find_by(name: params[:network_name]) && params[:new_network].empty?) || params[:description].empty? || params[:air_date].empty?
      flash[:message] = "Please fill out all required fields!"
      redirect '/shows/new'
    else
      @show = Show.create(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
      network = Network.find_by(name: params[:network_name])
      if !@network && !params[:new_network].empty?
        network = Network.create(name: params[:new_network])
      end
      @show.network_id = network.id
      @show.owner = current_user
      @show.users << current_user
      @show.save
      redirect "/shows/#{@show.slug}"
    end
  end

  get '/shows/:slug' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    erb :'/shows/detail'
  end

  get '/shows/:slug/add' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    @user.shows << @show
    redirect "/shows/#{@show.slug}"
  end

  get '/shows/:slug/edit' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if !@show
      flash[:message] = "Show not found."
      redirect '/shows'
    elsif @show && @show.owner == current_user
      erb :'/shows/edit'
    else
      flash[:message] = "You are not permitted to edit this entry."
      redirect '/shows'
    end
  end

  patch '/shows/:slug' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if params[:name].empty? || params[:genre].empty? || (!Network.find_by(name: params[:network_name]) && params[:new_network].empty?) || params[:description].empty? || params[:air_date].empty?
      flash[:message] = "Please fill out all required fields!"
      redirect '/shows/:slug/edit'
    else
      @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
      network = Network.find_by(name: params[:network_name])
      if !@network && !params[:new_network].empty?
        network = Network.create(name: params[:new_network])
      end
      @show.network_id = network.id
      @show.save
      redirect "/shows/#{@show.slug}"
    end
  end

  delete '/shows/:slug' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if @show && @show.owner == current_user
      @show.delete
      redirect '/shows'
    end
  end



end
