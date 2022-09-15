class UsersController < ApplicationController
  before_action :user_params, only: :update
  def show
  end

  def edit
  end

  def update

    if current_user.update_without_password(user_params)
      render :show
    else
      puts "$"*100
      pp current_user.errors
      puts "$"*100
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :cpf, :password)
  end
end
