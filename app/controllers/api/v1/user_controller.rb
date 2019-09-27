class Api::V1::UserController < ApplicationController
    before_action :set_user, only: %i[show update destroy]  
    wrap_parameters :user, include: %i[name password email description]
    
    def create
        @user= User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end
    
    def update
        if @user.update(user_params)
            render json: @user, status: :ok 
        else
            render json: @user.errors, status: :unprocessable_entity 
        end
    end
    
    def show
        render json: @user
    end

    def destroy
        @user.destroy
    end

    private
        def set_user
            @user = User.find(params[:id])
        end
        def user_params
            params.require(:user).permit(:name,:email,:description,:password)
        end

end