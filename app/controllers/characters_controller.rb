class CharactersController < ApplicationController
    #GET: http://localhost:3000/characters
    def index 
        @characters= Character.all;
       # if !params[:search].nil? && params[:search].present?
       #     @characters = CharactersSearchService.search(@characters,params[:search])
       #     render json:characters
       # end
        render json:@characters, only: [:id,:url_imagen,:nombre]
    end
    #GET: http://localhost:3000/characters/:id
    def show
        @character = Character.find(params[:id])
        render json:{ id:@character.id,url_imagen:@character.url_imagen,nombre: @character.nombre,edad: @character.edad,
                      peso:@character.peso,historia:@character.historia,movies:@character.movies},
                      status: :ok
    end

    def new
        @character =   Character.new
    end

    # POST: http://localhost:3000/characters
    def create 
        @character= Character.new(character_params)
        if @character.save
            render json: @character, status: :created, location: @character
        else
            render json: @character.errors, status: unprocessable_entity
        end
    end

    def edit
        @character= Character.find(params[:id])
        render json:@character
    end

    #PATCH: http://localhost:3000/characters/:id
    def update
        @character= Character.find(params[:id])
        if @character.update(character_params)
            render json:@character , status: :ok
        else
            render json:@character.errors, status: unprocessable_entity
        end
    end

    #DELETE: http://localhost:3000/characters/:id
    def destroy
        @character = Character.find(params[:id])
        @character.destroy
    end

    def movies
        @character = Character.find(params[:id])
        render json: {movies: @character.movies }
    end

    def character_create
        character = Character.find(params[:id])
        movie= Movie.new(params_film,character)
        movie.save
    end
    #creo metodo para pasarle los parametros 
    private    
    def character_params
        params.require(:character).permit(:url_imagen, :nombre, :edad, :peso, :historia)
    end
end
