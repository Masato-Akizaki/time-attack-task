class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:notice] = "登録が完了しました！"
      redirect_to tasks_url
    else
      flash[:alert] = "リンクが無効です"
      redirect_to signup_url
    end
  end

end