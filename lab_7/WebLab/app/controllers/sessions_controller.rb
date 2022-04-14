class SessionsController < ApplicationController
    def new
    end

    def create
        user = nil
        if (User.find_by email: params[:email]).nil?
            flash[:alert] = 'Пользователь не найден!'
            redirect_to request.referer
        else
            user = User.find_by email: params[:email]
            if !(user.password.to_s).eql?(hash(params[:password].to_s))
                flash[:alert] = 'Неверный пароль!'
                redirect_to request.referer
            else
                flash[:success] = "С возвращением, #{user.first_name} #{user.last_name}!"
                session[:user_id] = user.id
                redirect_to root_path
            end
        end
    end

    def destroy
        flash[:notice] = 'Пользователь покинул систему!'
        session[:user_id] = nil
        @current_user = nil
        redirect_to root_path
    end
end