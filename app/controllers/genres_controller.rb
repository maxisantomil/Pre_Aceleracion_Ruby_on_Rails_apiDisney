class GenresController < ApplicationController

      #GET: http://localhost:3000/genres
      def index 
        @genres= Genre.all;
        render json: @genres, only: [:id,:url_imagen,:nombre]    
    end

    #GET /:id
    def show
        @genre = Genre.find(params[:id])
        render json:{ id:@genre.id,url_imagen:@genre.url_imagen,nombre: @genre.nombre},status: :ok
    end

    def new
        @genre =  Genre.new
    end

    #POST
    def create 
        @genre= Genre.new(genre_params)

        if @genre.save
            render json: @genre, status: :created, location: @genre
        else
            render json: @genre.errors, status: unprocessable_entity
        end
    end

    def edit
        @genre= Genre.find(params[:id])
        render json:@genre
    end
    #PATCH/UPDATE
    def update
        @genre= Genre.find(params[:id])
        if @genre.update(genre_params)
           render json:@genre
        else
            render json:@genre.errors, status: unprocessable_entity
        end
    end

    #DELETE
    def destroy
        @genre = Genre.find(params[:id])
        @genre.destroy
    end


    private
    def genre_params
        params.require(:genre).permit(:url_imagen, :nombre)
    end
end
