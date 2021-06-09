require 'rails_helper'

describe 'Characters API',type: :request do
    #chequea para esa ruta devuelva todas los personajes ya guardadas,si es correcto :status success
    describe 'GET /characters' do
         #creando mock con FactoryBot
        before do
            FactoryBot.create(:character, url_imagen:'character1',nombre: 'chuwaca',edad:90,peso:180,historia:'personaje de star wars')
            FactoryBot.create(:character, url_imagen:'character2',nombre: 'darth vader',edad:190,peso:70,historia:'personaje de star wars')
        end
        it 'returns  all characters'do
            get 'http://localhost:3000/characters'
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2) 
        end
    end
    describe 'GET /characters/:id' do
        before do
            FactoryBot.create(:character,id:1,url_imagen:'character1',nombre: 'chuwaca',edad:90,peso:180,historia:'personaje de star wars')
        end
        it 'return single character'do
            get 'http://localhost:3000/characters/1'
            expect(response).to have_http_status(:ok)
        end
    end

    #chequea que se crea correctamente un nuevo personaje
    describe 'POST /characters' do
        it 'create a new character'do
        # chequea que al crear un personaje cambie el conteo de personajes de 0 a 1 .En este ejemplo.
          expect{
            post 'http://localhost:3000/characters',params: {character: {url_imagen:'url_darth.jpg',nombre:'darth vader',edad:90,peso:180,historia:'personaje'}}
            }.to change {Character.count }.from(0).to(1)

            expect(response).to have_http_status(:created)
        end
    end

    describe 'DELETE /characters/:id' do
        let!(:character) {FactoryBot.create(:character,url_imagen:'character3.jpg',nombre: 'chuwaca',edad:90,peso:180,historia:'personaje de star wars')}
        it 'deletes a character'do
            expect{
                delete "http://localhost:3000/characters/#{character.id}"
            }.to change {Character.count }.from(1).to(0)

            expect(response).to have_http_status(:no_content)
        end
    end
end