require 'rails_helper'

describe 'Movies API',type: :request do
    #chequea para esa ruta devuelva todas las peliculas/series ya guardadas,si es correcto :status success
    describe 'GET /movies' do
         #creando mock con FactoryBot
        before do
            FactoryBot.create(:movie, url_imagen:'star 1',titulo: 'star wars',fecha_creacion:'2012/02/03',calificacion:4)
            FactoryBot.create(:movie, url_imagen:'lord 1',titulo: 'the lord of the rings',fecha_creacion:'2010/01/03',calificacion:3)
            FactoryBot.create(:movie, url_imagen:'lord 2',titulo: 'the lord of the rings two',fecha_creacion:'2011/01/03',calificacion:4)
        end
        it 'returns  all movies'do
            get 'http://localhost:3000/movies'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(3) 
        end
    end
    describe 'GET /movies/:id' do
        before do
            FactoryBot.create(:movie,id:1,url_imagen:'star 1',titulo: 'star wars',fecha_creacion:'2012/02/03',calificacion:4)
        end
        it 'return single movie'do
            get 'http://localhost:3000/movies/1'
            expect(response).to have_http_status(:ok)
        end
    end

    #chequea que se crea correctamente una nueva pelicula/serie
    describe 'POST /movies' do
        it 'create a new movie'do
        # chequea que al crear una pelicula cambie el conteo de peliculas de 0 a 1 .En este ejemplo.
          expect{
            post 'http://localhost:3000/movies',params: {movie: {url_imagen:'url_mando.jpg',titulo:'the Mandalorian',fecha_creacion:'2020/05/01',calificacion:2}}
            }.to change {Movie.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /movies/:id' do
        let!(:movie) {FactoryBot.create(:movie,url_imagen:'star 1',titulo: 'star wars',fecha_creacion:'2012/02/03',calificacion:4)}
        it 'deletes  a movie'do
            expect{
                delete "http://localhost:3000/movies/#{movie.id}"
            }.to change {Movie.count }.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end
end