## RAILS CRUD

L'une des particularités de Rails est le fait que nous pouvons générer à la fois des contrôleurs et des modèles avec un générateur via votre terminal


### Generate
```console
  rails generate controller pages
```

### Destroy 

```console
  rails destroy controller pages
```

Nous avons auparavant créer des tableaux sur ActiveRecord ainsi que leurs timestamps

Exemple : 
```console
 rake db:timestamps
```


```console
rails generate model Restaurant name:string rating:integer
  invoke  active_record
      create    db/migrate/20211025184841_create_restaurants.rb
      create    app/models/restaurant.rb
      invoke    test_unit
      create      test/models/restaurant_test.rb
      create      test/fixtures/restaurants.yml
```



Migration 

```console
 rails db:migrate
```


then git 

```console
git status
git add .
git commit -m "Add restaurant model"
```



```console
rails g migration AddAddressToRestaurants 
      invoke  active_record
      create    db/migrate/20211025185010_add_address_to_restaurants.rb
```

```ruby
#/db/migrate/20211025185010_add_address_to_restaurants.rb
class AddAddressToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :address, :string
  end
end
```

```console
git status
git add .
git commit -m "Add address to Restaurant model"
```

Use of rails console 

```console
rails console
```

or 

```console
rails c 
```


Get all restaurants model :

```console
irb(main):003:0> Restaurant.all
   (1.0ms)  SELECT sqlite_version(*)
  Restaurant Load (0.5ms)  SELECT "restaurants".* FROM "restaurants" /* loading for inspect */ LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation []>
irb(main):004:0> 
```


No need to restart the console, you can do ```reload!``` inside your console

```console
irb(main):004:0> reload!
Reloading...
=> true
irb(main):005:0> 
```

and exit to get out of your console

```console
irb(main):005:0> exit
➜  rails_crud_activerecord git:(master) ✗ 
```


```console
rails console --sandbox
```

```console
irb(main):001:0> Restaurant.create(name:'Casa jose', rating: 5, address: 'Casa')
   (0.9ms)  SELECT sqlite_version(*)
  TRANSACTION (0.1ms)  begin transaction
  TRANSACTION (0.1ms)  SAVEPOINT active_record_1
  Restaurant Create (1.8ms)  INSERT INTO "restaurants" ("name", "rating", "created_at", "updated_at", "address") VALUES (?, ?, ?, ?, ?)  [["name", "Casa jose"], ["rating", 5], ["created_at", "2021-10-25 19:38:50.664131"], ["updated_at", "2021-10-25 19:38:50.664131"], ["address", "Casa"]]
  TRANSACTION (0.1ms)  RELEASE SAVEPOINT active_record_1
=> #<Restaurant id: 1, name: "Casa jose", rating: 5, created_at: "2021-10-25 19:38:50.664131000 +0000", updated_at: "2021-10-25 19:38:50.664131000 +0000", address: "Casa">
irb(main):002:0> 
```



## CRUD ACTIONS



#Get all restaurants 

```ruby

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'restaurants', to: "restaurants#index"
end

```

we have to generate the controller 

```console 
rails g controller restaurants
Running via Spring preloader in process 39695
      create  app/controllers/restaurants_controller.rb
      invoke  erb
      create    app/views/restaurants
      invoke  test_unit
      create    test/controllers/restaurants_controller_test.rb
      invoke  helper
      create    app/helpers/restaurants_helper.rb
      invoke    test_unit
      invoke  assets
      invoke    scss
      create      app/assets/stylesheets/restaurants.scss
```



#Get all the restaurants 


#controller 


```ruby 
class RestaurantsController < ApplicationController
    def index
        @restaurants = Restaurant.all
    end
end
```


```ruby
<!-- app/views/restaurants/index.html.erb -->
<ul>
    <% @restaurants.each do |restaurant| %>
      <li><%= restaurant.name %></li>
    <% end %>
  </ul>
```


#get One restaurant

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'restaurants', to: "restaurants#index"
  get 'restaurants/:id', to: "restaurants#show", as: :restaurant
end
```

let's check out our rails routes 

```console
rails routes
     Prefix Verb URI Pattern                Controller#Action
restaurants GET  /restaurants(.:format)     restaurants#index
 restaurant GET  /restaurants/:id(.:format) restaurants#show
```


```ruby
<!-- app/views/restaurants/show.html.erb -->
<h2><%= @restaurant.name %></h2>
<p><%= @restaurant.address %></p>
<p><%= @restaurant.rating %></p>
```



NEW RESTAURANT 

Defining the routes 

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'restaurants', to: "restaurants#index"
  get 'restaurants/:id', to: "restaurants#show", as: :restaurant
  get 'restaurant/new', to: "restaurants#new", as: :new_restaurant
end

```

controller 

```ruby
class RestaurantsController < ApplicationController

    def index
        @restaurants = Restaurant.all
    end

    def show 
        @restaurant = Restaurant.find(params[:id]) #this is for the form_for 
    end

    def new 
        @restaurant = Restaurant.new 
    end
end
```

view 

```ruby
<%= form_for(@restaurant) do |f| %>
    <%= f.label :name%>
    <%= f.text_field :name%>
    <%= f.label :address %>
    <%= f.text_field :address%>
    <%= f.label :rating%>
    <%= f.number_field :rating%>
    <%= f.submit%>
<% end %>
```


#strong params 

```console
rails routes
        Prefix Verb URI Pattern                Controller#Action
   restaurants GET  /restaurants(.:format)     restaurants#index
    restaurant GET  /restaurants/:id(.:format) restaurants#show
new_restaurant GET  /restaurant/new(.:format)  restaurants#new
```