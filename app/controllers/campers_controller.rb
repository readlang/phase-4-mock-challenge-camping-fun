class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        campers = Camper.all
        render json: campers
    end

    def show
        render json: Camper.find(params[:id]), serializer: CamperActivitySerializer
    end

    def create
        new_camper = Camper.create!( {name: params[:name], age: params[:age]} )
        
        render json: new_camper, status: :created
  
    end

    private

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

end