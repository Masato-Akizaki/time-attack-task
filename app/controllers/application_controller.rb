class ApplicationController < ActionController::Base
  include SessionsHelper

  def save_return_url
    session[:return_to] = request.referer
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:alert] = "ログインしてください"
        redirect_to login_url
      end
    end
end
