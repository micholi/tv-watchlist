class NetworksController < ApplicationController

  get '/networks' do
    @networks = Network.all.order(:name)
    erb :'/networks/index'
  end

  get '/networks/:slug' do
    @network = Network.find_by_slug(params[:slug])
    erb :'/networks/info'
  end

end
