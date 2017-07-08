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
    if !params[:figure][:title_ids].nil?
      params[:figure][:title_ids].each do |title_id|
        Figure.all.last.titles << Title.find_by(id: title_id)
      end
    end
    if !params[:figure][:landmark_ids].nil?
      params[:figure][:landmark_ids].each do |landmark_id|
        Figure.all.last.landmarks << Landmark.find_by(id: landmark_id)
      end
    end
    if params[:title][:name] != ""
      @figure.titles << Title.create(params[:title])
    end
    if params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed], figure_id: @figure.id)
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @landmarks = @figure.landmarks
    erb :show
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(id: params[:id])
    erb :edit
  end

  patch '/figures/:id' do
    @figure = Figure.find_by(id: params[:id])
    @figure.update(name: params[:figure][:name])
    if params[:figure][:landmark] != ""
      @landmark = Landmark.create(name: params[:figure][:landmark][:name])
      @figure.landmarks << @landmark
      @landmark.figure_id = @figure.id
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end
