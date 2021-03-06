class UsersController < ApplicationController
  before_action :logged_in_user, only:[:index, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: [:destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def new
    @user = User.new(session[:user] || {})
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "メールを送信しました。メールに記載されたURLをクリックして、登録を完了してください。"
      redirect_to users_url
    else
      session[:user] = @user.attributes.slice(*user_params.keys)
      flash[:alert] = @user.errors.full_messages
      redirect_to signup_url
    end
  end
    
  def show
    redirect_to users_url and return unless @user.activated?
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_url
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to edit_user_url
    end
  end

  def destroy
    if @user.nil?
      redirect_to users_url
    elsif @user.destroy
      redirect_to users_url
    else
      redirect_to users_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(login_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(users_url) unless correct_user.admin?
    end

    def set_user
      @user = User.find(params[:id])
    end
end
