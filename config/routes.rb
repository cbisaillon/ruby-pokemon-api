Rails.application.routes.draw do
  get '/pokemons', to: "pokemons#index"
  get '/pokemons/:id', to: "pokemons#view"
end
