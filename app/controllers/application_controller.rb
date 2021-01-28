class ApplicationController < ActionController::Base
  include SessionsHelper

# 例外処理
rescue_from Exception, with: :render_500
rescue_from ActiveRecord::RecordNotFound, with: :render_404
rescue_from ActionController::RoutingError, with: :render_404
rescue_from NoMethodError, with: :render_404

def render_403
  render template: 'errors/error_403', status: 403, layout: 'application', content_type: 'text/html'
end

def render_404
  render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
end

def render_500
  render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:alert] = "ログインしてください"
        redirect_to login_url
      end
    end

    def save_return_url
      session[:return_to] = request.referer
    end
end
