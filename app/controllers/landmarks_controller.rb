class LandmarksController < ApplicationController

  set :views, 'app/views/landmarks/'

    # get '/landmarks' do
    #   erb :'/landmarks/new'
    # end
    #
    # post '/landmarks/new' do
    #   @landmark = Landmark.create(params)
    #   erb :'/landmarks/'
    # end
    #
    get '/landmarks/:id' do
      @landmark = Landmark.find_by(id: params[:id])
      erb :show
    end

end
