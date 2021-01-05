class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:notice] = "パスワード再設定のメールを送信しました"
      redirect_to login_url
    else
      flash[:alert] = "メールアドレスが登録されていません"
      redirect_to new_password_reset_url
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_password_reset_url(params[:id], email: params[:email])
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:notice] = "パスワードをリセットしました"
      redirect_to @user
    else
      session[:user] = @user.attributes.slice(*user_params.keys)
      flash[:danger] = @user.errors.full_messages
      redirect_to edit_password_reset_url(params[:id], email: params[:email])
    end
  end


  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end
    
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to login_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:alert] = "パスワードのリセットが期限切れになりました。"
        redirect_to new_password_reset_url
      end
    end
end
