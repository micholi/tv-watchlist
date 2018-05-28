class ShowsController < ApplicationController

  get '/shows' do
    #binding.pry
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
      redirect '/shows/new'
    elsif params[:name] == ""|| params[:genre] == "" || params[:network] == "" || params[:description] == "" || params[:air_date] == ""
      flash[:message] = "Please fill out all fields to add a new show."
      redirect 'shows/new'
    else
      @show = Show.create(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
      network = Network.find_or_create_by(name: params[:network])
      @show.network_id = network.id
      @show.owner = current_user
      @show.users << current_user
      @show.save
      flash[:message] = "Your new show has been added."
      redirect "/shows/#{@show.slug}"
    end
  end

  get '/shows/:slug' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    erb :'/shows/detail'
  end

  get '/shows/:slug/edit' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if @show && @show.owner == current_user
      erb :'/shows/edit'
    else
      flash[:message] = "You are not permitted to edit this show."
      redirect :'/watchlist'
    end
  end

  patch '/shows/:slug' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if params[:name] == ""|| params[:genre] == "" || params[:network] == "" || params[:description] == "" || params[:air_date] == ""
      flash[:message] = "Please fill out all fields to edit this show."
      redirect :'/shows/:slug/edit'
    else
      @show.update(name: params[:name], genre: params[:genre], description: params[:description], air_date: params[:air_date])
      network = Network.find_or_create_by(name: params[:network])
      @show.network_id = network.id
      @show.save
      flash[:message] = "Your show has been updated successfully."
      redirect "/shows/#{@show.slug}"
    end
  end

  get '/shows/:slug/add' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    @user.shows << @show
    redirect "/watchlist"
  end

  get '/shows/:slug/remove' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    association = UserShow.find_by(user_id: @user.id, show_id: @show.id)
    association.delete
    redirect "/watchlist"
  end

  delete '/shows/:slug/delete' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if @show && @show.owner == current_user
      @show.delete
      flash[:message] = "This show has been permanently deleted."
      redirect '/shows'
    end
  end

  # prevent manual deletion of show by user without permissions
  get '/shows/:slug/delete' do
    user_check
    @show = Show.find_by_slug(params[:slug])
    if @show && @show.owner != current_user
      flash[:message] = "You are not permitted to delete this show."
      redirect '/shows'
    end
  end

end
