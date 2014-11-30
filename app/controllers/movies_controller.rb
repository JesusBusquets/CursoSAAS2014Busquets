class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.find(:all,:order => params[:order], :conditions => {:rating => params[:ratings].keys})
    @all_ratings = Movie.all_ratings
    @selections =  {:rating => params[:ratings].keys}
    flash[:notice] = params.inspect # + ratings.inspect

  end

  def new
    # default: render 'new' template
  end
  # Checks if user is new
  def new
     @user = Person.find(:first)
     @user.active = true
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
