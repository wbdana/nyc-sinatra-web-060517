class FiguresController < ApplicationController

  # set :views, 'app/views/figures'

  # get '/figures' do
  #   @figures = Figure.all
  #   erb :'figures/new'
  # end

  get '/figures' do
    # binding.pry
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params)
  end


end
