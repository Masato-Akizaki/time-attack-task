class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or tasks_url
      else 
        message = "アカウントが有効ではありません。"
        message += "メールを確認して登録を完了させてください。"
        flash[:alert] = message
        redirect_to login_url
      end
    else
      flash[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      redirect_to login_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
