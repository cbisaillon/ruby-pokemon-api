# Pokedex on rails

## Before running
1. Install the dependencies `./bin/bundle install`
1. Create the database: `./bin/rake db:create`   
1. Run the migrations: `./bin/rails db:migrate`
1. Seed the pokemon data to the database: `./bin/bundle exec /usr/bin/ruby ./scripts/import-pokemons.rb`
1. Run the application: `./bin/rails server -b 0.0.0.0 -p 3000 -e development`

## Endpoints
Definition of endpoints provided by this app

### Pokemons

#### List the pokemons
`GET /pokemons`

Inputs:

| Query param | Description | Is optional ? | default |
|----|----|----|----|
|page|Specify the page for the pagination.|yes|1|
|per_page|Specify the number of items to return for the pagination.|yes|10|

Outputs:

```
{
  "page": number, // the current page
  "per_page": number, // the number of result per page
  "has_next": boolean, // indicates if there is a next page
  "has_prev": boolean, // indicates if there is a previous page
  "pokemons": array_of_pokemons, // Results for the current page
}
```

#### View a specific pokemon
`GET /pokemons/:id`

Returns the informations stored in the database for the pokemon with the id provided in the url.

#### Create a pokemon
`POST /pokemons/create`

Inputs:

| POST param | Description | Is optional ? |
|----|----|----|
|number|Number of the pokemon|no|-|
|name|Name of the pokemon|no|-|
|type_1_id|Primary type of the pokemon|no|-|
|type_2_id|Secondary type of the pokemon|yes|-|
|total|Total level of the pokemon|yes|-|
|hp|Health points of the pokemon|yes|-|
|attack|Attack level of the pokemon|yes|-|
|defense|Defense level of the pokemon|yes|-|
|sp_attack|Special attack level of the pokemon|yes|-|
|sp_defense|Special defense level of the pokemon|yes|-|
|speed|Speed of the pokemon|yes|-|
|generation|Generation in which this pokemon appears|yes|-|
|is_legendary|Specifies if the pokemon is legendary|yes|-|

Outputs

This endpoint returns the created pokemon

```
{
  "id": number,
  "number": number,
  "name": string,
  "type_1_id": number,
  "type_2_id": number,
  "total": number,
  "hp": number,
  "attack": number,
  "defense": number,
  "sp_attack": number,
  "sp_defense": number,
  "speed": number,
  "generation": number,
  "is_legendary": boolean,
  "created_at": datetime,
  "updated_at": datetime
}
```

#### Update a pokemon
`POST /pokemons/:id/update`

Inputs:

| POST param | Description | Is optional ? |
|----|----|----|
|number|Number of the pokemon|yes|
|name|Name of the pokemon|yes|
|type_1_id|Primary type of the pokemon|yes|
|type_2_id|Secondary type of the pokemon|yes|-
|total|Total level of the pokemon|yes
|hp|Health points of the pokemon|yes|
|attack|Attack level of the pokemon|yes|
|defense|Defense level of the pokemon|yes|
|sp_attack|Special attack level of the pokemon|yes|
|sp_defense|Special defense level of the pokemon|yes|
|speed|Speed of the pokemon|yes|
|generation|Generation in which this pokemon appears|yes|
|is_legendary|Specifies if the pokemon is legendary|yes|

Outputs:

This endpoints returns the updated pokemon.

```
{
  "id": number,
  "number": number,
  "name": string,
  "type_1_id": number,
  "type_2_id": number,
  "total": number,
  "hp": number,
  "attack": number,
  "defense": number,
  "sp_attack": number,
  "sp_defense": number,
  "speed": number,
  "generation": number,
  "is_legendary": boolean,
  "created_at": datetime,
  "updated_at": datetime
}
```

#### Delete a pokemon
`POST /pokemons/:id/delete`

Delete the pokemon with the id specified in the url.

Returns:

The pokemon that was deleted

### Types

#### List the types
`GET /types`

Returns the an array of all the types in the database

#### Create a type
`POST /types/create`

Inputs:

| POST param | Description | Is optional ? |
|----|----|----|
|type_name|Name of the type|no|


Returns:

The newly created type

#### Delete a type
`POST /types/:id/delete`

Deletes the type with the id specified in the url.

Returns:

The deleted type.

