class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render :json => { :errors => user.errors.full_messages }, :status => 401
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email)
  end
end
