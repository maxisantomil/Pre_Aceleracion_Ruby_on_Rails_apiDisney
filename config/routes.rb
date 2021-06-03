Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   #me muestra todas las peliculas 
   get '/movies', to:'movies#index'

   get'/movies/new', to:'movies#new'
 
   post '/movies', to:'movies#create'
 
   #me muestra una movie/serie en particular con todas sus caracteristicas y personajes asociados
   get'/movies/:id', to:'movies#show',as: 'movie'
 
   get'/movies/:id/edit', to:'movies#edit',as:'edit_movie'
 
   patch'/movies/:id', to:'movies#update'
 
   put'/movies/:id', to:'movies#update'
 
   delete'/movies/:id', to: 'movies#destroy'
 
 #---------------------------------------------------------------------------------------------------
 
 
   resources :characters
 
   resources :genres
end
