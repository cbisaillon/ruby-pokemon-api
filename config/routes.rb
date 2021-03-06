Rails.application.routes.draw do
  get '/pokemons', to: "pokemons#index"
  get '/pokemons/:id', to: "pokemons#view"
  post "/pokemons/:id/delete", to: "pokemons#delete"
  post '/pokemons/:id/update', to: "pokemons#update"
  post '/pokemons/create', to: "pokemons#create"

  get '/types', to: "types#index"
  post "/types/create", to: "types#create"
  post "/types/:id/delete", to: "types#delete"
end
