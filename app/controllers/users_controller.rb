class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.signup_confirmation(@user).deliver
      flash[:notice] = "Thank you for making an account, we promise to send an e-mail within the next 87 days"
      redirect_to "/"
    else
      flash[:notice] = "There was a problem creating your account. Please try again"
      redirect_to :back
    end
  end

  def edit
    @user = User.find(params[:id])
  end


  def update
    current_user = User.find(params[:id])
    if current_user.update(user_params)
      flash[:notice] = "Added to profile!"
      redirect_to :back
    else
      flash[:notice] = "You failed."
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :bio, :interest)

  end
end
