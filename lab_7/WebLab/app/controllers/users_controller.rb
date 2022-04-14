class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        @user.password = hash(@user.password)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Добро пожаловать, #{@user.first_name} #{@user.last_name}!"
            redirect_to root_path
        else
            flash[:alert] = "Регистрация не прошла успешно!"
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end