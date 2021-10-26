## RAILS CRUD cheatseets

### Generate
```console
  rails generate controller pages
```

### Destroy 
```console
  rails destroy controller pages
```

### Generate a model

```console
rails generate model Restaurant name:string rating:integer
  invoke  active_record
      create    db/migrate/20211025184841_create_restaurants.rb
      create    app/models/restaurant.rb
      invoke    test_unit
      create      test/models/restaurant_test.rb
      create      test/fixtures/restaurants.yml
```


### Migration 

```console
 rails db:migrate
```

### Add a column to your table

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

### Rails console

```console
rails console
```

or 

```console
rails c 
```


### Get all restaurants through your console :

```console
irb(main):003:0> Restaurant.all
   (1.0ms)  SELECT sqlite_version(*)
  Restaurant Load (0.5ms)  SELECT "restaurants".* FROM "restaurants" /* loading for inspect */ LIMIT ?  [["LIMIT", 11]]
=> #<ActiveRecord::Relation []>
irb(main):004:0> 
```

### Reload !
No need to restart the console for any upcoming changes or updates in your app, you can do ```reload!``` inside your rails console

```console
irb(main):004:0> reload!
Reloading...
=> true
irb(main):005:0> 
```

### Sandbox

Sandbox helps you to create fictional data for testing, everything is erased once you exit your rails console. 

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

### GET | INDEX
```ruby

**Routes**

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'restaurants', to: "restaurants#index"
end

```

**Generate controller**

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

**Controller**

```ruby 
class RestaurantsController < ApplicationController
    def index
        @restaurants = Restaurant.all
    end
end
```

**View of INDEX**
```ruby
<!-- app/views/restaurants/index.html.erb -->
<ul>
    <% @restaurants.each do |restaurant| %>
      <li><%= restaurant.name %></li>
    <% end %>
  </ul>
```


### GET | SHOW

**Routes**
```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    #... other routes
  get 'restaurants/:id', to: "restaurants#show", as: :restaurant
    #... other routes
end
```

**Controller**

```ruby
class RestaurantsController < ApplicationController
    def show
        @restaurant = Restaurant.find(params[:id])
    end
end
```

**View**

```ruby
<!-- app/views/restaurants/show.html.erb -->
<h2><%= @restaurant.name %></h2>
<p><%= @restaurant.address %></p>
<p><%= @restaurant.rating %></p>
```



### GET | NEW

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    #... other routes
  get 'restaurant/new', to: "restaurants#new", as: :new_restaurant
    #... other routes
end

```

**Controller**

```ruby
class RestaurantsController < ApplicationController
    def new 
        @restaurant = Restaurant.new 
    end
end
```

**View**

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

### POST | CREATE

**Routes**
```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    #... other routes
  post 'restaurants', to: "restaurants#create"
    #... other routes
end

```

**Controller**

```ruby
    def create 
        @restaurant = Restaurant.create(restaurant_params)
        @restaurant.save
        redirect_to restaurants_path
    end
```


### GET | EDIT


**Routes**
```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    #... other routes
  get 'restaurants/:id/edit', to: 'restaurants#edit', as: :edit_restaurant
    #... other routes
end

```

**Controller**

```ruby
class RestaurantsController < ApplicationController
    def edit
        @restaurant = Restaurant.find(params[:id])
    end
end
```

**View**

```ruby 
#/app/views/restaurants/edit.html.erb
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

### PATCH | UPDATE

**Routes**

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #... other routes
  patch 'restaurants/:id', to: 'restaurants#update'
  #...other routes
end
```

**Controller**

```ruby
   def update 
        @restaurant = Restaurant.find(params[:id])
        @restaurant.update(restaurant_params)
        redirect_to restaurant_path(@restaurant)
   end
```

### DELETE | DESTROY

**Routes**

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #... other routes
  delete "restaurants/:id", to: "restaurants#destroy"
  #...other routes
end
```

**Controller**

```ruby
   def destroy
        @restaurant = Restaurant.find(params[:id])
        @restaurant.destroy 
        redirect_to restaurants_path
    end
```