class Api::V1::UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]
    before_action :check_owner, only: %i[update destroy]  
    wrap_parameters :user, include: %i[name password email description]
    
    def index
       @users = User.all
       render json: @users
    end


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
        def check_owner
            head :forbidden unless @user.id == current_user&.id
        end

end