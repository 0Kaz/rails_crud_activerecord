## RAILS CRUD cheatseets :rocket:


*Summary:*
 - [ActiveRecord](#activerecord-rails)
      - [Generate a controller](#generate-a-controller)
      - [Generate a model](#generate-a-model)
      - [Destroy a controller or a model](#destroy-a-controller-or-a-model)
      - [Migration](#migration)
      - [Add a column to your table](#add-a-column-to-your-table)
      - [Drop a column from your table ](#drop-a-column-from-your-table)
      - [Get all restaurants through your Rails console :](#get-all-restaurants-through-your-Rails-console)
      - [Reload!](#reload!)
      - [Sandbox](#sandbox)

## ActiveRecord Rails
### Generate a controller 

```console
  rails generate controller pages
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


### Destroy a controller or model
```console
  rails destroy controller name_of_your_controller
  rails destroy model name_of_your_model
```

### Migration 

```console
 rails db:migrate
```

### Add a column to your table

```console
rails g migration AddAddressToRestaurants  address:string
      invoke  active_record
      create    db/migrate/20211025185010_add_address_to_restaurants.rb
```

### Drop a column from your table 
```console
rails g migration RemoveAddressFromRestaurants address:string
      invoke  active_record
      create    db/migrate/20211025185010_remove_address_from_restaurants.rb
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


### Get all restaurants through your Rails console

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

#### Generate controller

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

**View**
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


## Why we don't use regular HTML Form Tags in Rails

Regular HTML forms will caught us fetching each input params which can be tedious :

```html
<form action='/restaurants' method='post'>
  <label for='name'></label>
  <input type='text' name='name'/>
  <label for='address'></label>
  <input type='text' name='address'/>
  <label for='rating'></label>
  <input type='text' name='rating'/>
  <input type='submit'/>
</form>
```

```ruby
params[:name]
params[:address]
#...etc 
```

**The solution is to use Rails form tags instead** 

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
This will collect all our params into one : 
```ruby 
  params[:restaurant] #=> {name: name, address: address, rating: rating}
```


## Strong Params

When you try to fill a form and submit it with a post method, you might have this first thought to simply do something like this : 


```ruby
    def create 
        @restaurant = Restaurant.create(params[:restaurant])
        @restaurant.save
        redirect_to restaurants_path
    end
```

Check out what you will get once you use ```raise``` in your create action :

![Fail params](https://res.cloudinary.com/kzkjr/image/upload/v1635251480/blogging/Capture_d_e%CC%81cran_2021-10-26_a%CC%80_13.26.44.png)


We want these params to be permitted to be created in our DB. ```The solution is to use strong_params```

![Pass params](https://res.cloudinary.com/kzkjr/image/upload/v1635251480/blogging/Capture_d_e%CC%81cran_2021-10-26_a%CC%80_13.27.23.png)

### The solution is to use a Strong Params 

```ruby 
   def restaurant_params
        params.require(:restaurant).permit(:name, :address, :rating)
    end

```


## simple_form

First of all, you need to put the gem in your Gemfile in your rails app.

```ruby
gem 'simple_form'
```

then in your console, type this command to generate the installation of ```simple_form``` including bootstrap 

```console
rails generate simple_form:install --bootstrap
```

and use the ```simple_form``` instead of a regular ```form_for```

```ruby 
<%= simple_form_for(restaurant) do |f| %>
  <%= f.input :name %>
  <%= f.input :rating %>
  <%= f.submit %>
<% end %>
```


### Bootstrap 

You can install bootstrap through yarn instead of adding it on your Gemfile 

```console
yarn add bootstrap
```

Then you'll have to rename this file on ```app/assets/stylesheets/application.css``` into ```app/assets/stylesheets/application.scss```

and add this line on your ```application.scss```

```scss
 @import "bootstrap/scss/bootstrap";
```