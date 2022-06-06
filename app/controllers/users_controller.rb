class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index 
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page])
    @time = Time.now
  end

  def create
    @user = User.new(user_params)
    Rails.logger.debug "----------- 1 -------------"
    if @user.save
      Rails.logger.debug "----------- 2 -------------"
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "届いたメールにて本人確認を実施してください"
      redirect_to root_url
    else
      Rails.logger.debug "----------- 3 -------------"
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新成功"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    # 自身のアカウントでログインしているか確認
    def correct_user 
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうかの確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
