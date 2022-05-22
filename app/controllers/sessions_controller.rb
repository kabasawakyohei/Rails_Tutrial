class SessionsController < ApplicationController
  # /login get
  def new
  end

  # /login post
  def create
    user = User.find_by(email: params[:session][:email])
    if !user.nil? && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user
    else
      flash[:danger] = "emailとパスワードが違います"
      render 'new'
    end
  end


  # /logout
  def destroy
  end
end
