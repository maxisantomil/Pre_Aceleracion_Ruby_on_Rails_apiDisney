class MoviesController < ApplicationController

    #GET: http://localhost:3000/movies
    def index 
        @movies= Movie.all;
        render json: @movies, only: [:id,:url_imagen,:titulo,:fecha_creacion]    
    end

     #GET: http://localhost:3000/movies/:id
    def show
        @movie = Movie.find(params[:id])
        render json:{ id:@movie.id,url_imagen:@movie.url_imagen,titulo: @movie.titulo,fecha_creacion: @movie.fecha_creacion,
                      calificacion:@movie.calificacion,characters:@movie.characters,genero:@movie.genres},status: :ok
    end

    def new
        @movie =  Movie.new
    end

    # POST: http://localhost:3000/movies
    def create 
        @movie= Movie.new(movie_params)

        if @movie.save
            render json: @movie, status: :created, location: @movie
        else
            render json: @movie.errors, status: unprocessable_entity
        end
    end

    def edit
        @movie= Movie.find(params[:id])
        render json:@movie
    end

    #PATCH: http://localhost:3000/movies/:id
    def update
        @movie= Movie.find(params[:id])
        if @movie.update(movie_params)
           render json:@movie
        else
            render json:@movie.errors, status: unprocessable_entity
        end
    end

    #DELETE: http://localhost:3000/movies/:id
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
    end

    def characters
        @movie = Movie.find(params[:id])
        render json: {characters: @movie.characters }
    end 


    
    
    #creo metodo para pasarle los parametros 
    private    
    def movie_params
        params.require(:movie).permit(:url_imagen, :titulo, :fecha_creacion, :calificacion)
    end
end
