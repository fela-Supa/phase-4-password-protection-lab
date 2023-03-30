class UsersController < ApplicationController
    before_action :authorize, only: [:show]

    def create
        user = User.create(user_params)

        if user.valid?
        session[:user_id] = user.id
        render json: user, status: :unprocessable_entity
        else  
            render json: { error: user.errors.full_messages}, status: 422
        end 
    
        
    end


    def show  
        user = User.find(session[:user_id])
        if user
            render json: user
        else 
            render json: {errors: user.errors.full_messages}, status: :not_found
        end
    end



    private 

    def user_params 

        params.permit(:id, :username, :password)

    end


    def authorize  
        unless session.include? :user_id 
            render json: {error: "Not authorized"}, status: :unauthorized
        end

    end
end
