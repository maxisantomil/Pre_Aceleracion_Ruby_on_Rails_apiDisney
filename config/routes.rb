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

   get '/movies/:id/characters', to:'movies#characters'
 
 #---------------------------------------------------------------------------------------------------
  # simplifico con resources para characters y genres
   #resources :characters

   resources :characters do
    resources :movies
  end

   resources :genres

   resources :users, only: [:create,:destroy]

   post 'users/login', to: 'users#login'

   get 'users/profile', to: 'users#profile'

   get 'users/auto_login', to: 'users#auto_login'

end
