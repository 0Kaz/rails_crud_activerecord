class RestaurantsController < ApplicationController

    def index
        @restaurants = Restaurant.all
    end

    def show 
        @restaurant = Restaurant.new #this is for the form_for 
    end
end
