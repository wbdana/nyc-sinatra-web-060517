class FiguresController < ApplicationController

  set :views, 'app/views/figures'

  get '/figures' do
    @figures = Figure.all
    # binding.pry
    erb :index
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :new
  end

  post '/figures' do
    # binding.pry
    @figure = Figure.create(params[:figure])
    if !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].each do |title_id|
        Figure.all.last.titles << Title.find_by(id: title_id)
      end
    end
    if !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].each do |landmark_id|
        Figure.all.last.landmarks << Landmark.find_by(id: landmark_id)
      end
    end
    if !params[:title][:name].length == 0
      @title = Title.create(params[:title])
      @title.figure = @figure
    end
    if !params[:landmark][:name].length == 0
      @landmark = Landmark.create(params[:landmark])
      @figure.landmarks << @landmark
      @landmark.figure = @figure
    end
    erb :show
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    erb :show
  end

end
