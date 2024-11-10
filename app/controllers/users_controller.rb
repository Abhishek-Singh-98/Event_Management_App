class UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: {error: 'Data missing'}
    end
  end

  private 

  def user_params
    params.permit(:name, :email, :contact_number, :user_type)
  end
end
