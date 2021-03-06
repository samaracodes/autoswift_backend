class Api::V1::CarsController < ApplicationController
    def index
        cars = Car.all
        render json: CarSerializer.new(cars)
    end

    def create
        car = Car.new(car_params)
        if car.save
            render json: CarSerializer.new(car), status: :accepted
            #allows us to send status code with our fetch request. 
        else
            render json: {errors: car.errors.full_messages}
            
        end
    end

    def update
        car = Car.find_by_id(params[:id])
        if car.update(car_params)
            render json: CarSerializer.new(car)
        else
            render json: {error: "Could not save"}
        end
    end

    def destroy
        car = Car.find_by_id(params[:id])
        car.destroy
        render json: {message: "Successfully deleted #{car.year} #{car.brand} #{car.model}!"}
    end

    private

    def car_params
        params.require(:car).permit(:year, :brand, :model, :price, :image_url, :user_id)
    end
end
