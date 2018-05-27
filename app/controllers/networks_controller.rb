class NetworksController < ApplicationController

  get '/networks' do
    user_check
    @networks = Network.all.order(:name)
    erb :'/networks/index'
  end

  get '/networks/:slug' do
    user_check
    @network = Network.find_by_slug(params[:slug])
    erb :'/networks/info'
  end

end
