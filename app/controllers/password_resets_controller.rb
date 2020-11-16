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
      @user.sent_password_reset_email
      flash[:info] = "パスワード再設定のメールを送信しました"
      redirect_to login_url
    else
      flash.now[:danger] = "メールアドレスが登録されていません"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attributes(:reset_digest, nil)
      flash[:success] = "パスワードをリセットしました"
      redirect_to @user
    else
      render 'edit'
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
end