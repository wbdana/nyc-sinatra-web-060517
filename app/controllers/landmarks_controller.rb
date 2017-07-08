class LandmarksController < ApplicationController

  set :views, 'app/views/landmarks/'

    get '/landmarks' do
      @landmarks = Landmark.all
      erb :index
    end

    get '/landmarks/new' do
      erb :new
    end

    post '/landmarks' do
      # binding.pry
      @landmark = Landmark.create(params[:landmark])
      erb :show
    end

    get '/landmarks/:id' do
      @landmark = Landmark.find_by(id: params[:id])
      erb :show
    end

    get '/landmarks/:id/edit' do
      @landmark = Landmark.find_by(id: params[:id])
      erb :edit
    end

    patch '/landmarks/:id' do
      @landmark = Landmark.find_by(id: params[:id])
      @landmark.update(params[:landmark])
      redirect "/landmarks/#{@landmark.id}"
    end

end
