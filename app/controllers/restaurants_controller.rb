class RestaurantsController < ApplicationController
    before_action :restaurant_set_id, only: [:show,:destroy, :update, :edit]
    def index
        @restaurants = Restaurant.all
    end

    def new 
        @restaurant = Restaurant.new 
    end

    def show 
    end

    def create 
        @restaurant = Restaurant.create(restaurant_params)
        @restaurant.save
        redirect_to restaurants_path
    end

    def edit
    end

    def update 
        @restaurant.update(restaurant_params)
        redirect_to restaurant_path(@restaurant)
    end


    def destroy
        @restaurant.destroy 

        redirect_to restaurants_path
    end

    private 
    
    def restaurant_params
        params.require(:restaurant).permit(:name, :address, :rating)
    end

    def restaurant_set_id
        @restaurant = Restaurant.find(params[:id])
    end
end


