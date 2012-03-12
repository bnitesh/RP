class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if !params[:ratings].nil? and !params[:sort].nil? then
      @movies = Movie.where(:rating => params[:ratings].keys).order(params[:sort].to_s)
      session[:sort] = params[:sort]
      session[:ratings] = params[:ratings].keys
    elsif !params[:ratings].nil? then
      @movies = Movie.where(:rating => params[:ratings].keys)
      session[:ratings] = params[:ratings].keys
      session[:sort] = ""
    elsif !params[:sort].nil? then
      session[:sort] = params[:sort]
      if session[:ratings].empty? then
        session[:ratings] = []
        @movies = Movie.order(params[:sort].to_s)
      else
        @movies = Movie.where(:rating => session[:ratings]).order(params[:sort].to_s)
      end    
    else
      @movies = Movie.all
      session[:sort] = ""
      session[:ratings] = []
    end
    @all_ratings = []
    Movie.all.each do |movie|
      @all_ratings << movie.rating
    end
    @all_ratings.uniq!.sort!
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
