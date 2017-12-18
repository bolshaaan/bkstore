class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      redirect_to books_path
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to welcome_index_url
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password, :remember_me)
  end
end


