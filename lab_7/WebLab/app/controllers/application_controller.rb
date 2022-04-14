require 'digest'
class ApplicationController < ActionController::Base

    private
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
        current_user.present?
    end

    def hash(password)
        return Digest::SHA256.hexdigest(password.to_s)
    end

    helper_method :current_user, :user_signed_in?, :hash
end
