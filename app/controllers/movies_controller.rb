class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    if params.has_key? :ratings
        @selections = params[:ratings] 
	ordenar = params[:order]
   elsif session.has_key?(:ratings)
	@selections = session[:ratings]
        ordenar =  session[:order]
    else
        @selections = {}
        ordernar =""
    end	
	
    if @selections.empty?
       @movies = Movie.find(:all,:order => ordenar)
    else    
       @movies = Movie.find(:all,:order => ordenar,  :conditions => {:rating => @selections.keys})
    end
    @all_ratings = Movie.all_ratings
    session[:ratings] = @selections
    session[:order] = params[:order]
    #flash[:notice] = params.inspect  + @selections.inspect
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
