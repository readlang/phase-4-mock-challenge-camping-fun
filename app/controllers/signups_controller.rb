class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        render json: Signup.all
    end

    def create
        new_signup = Signup.create!({
            time: params[:time], 
            camper_id: params[:camper_id], 
            activity_id: params[:activity_id] 
        })
       
        render json: new_signup.activity, status: :created
        
    end

    private

    def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end



end