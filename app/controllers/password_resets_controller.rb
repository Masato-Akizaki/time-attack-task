class PasswordResetsController < ApplicationController
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
end
