class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id]).to_json
  end

  def create
    user = User.new(user_params)
    if user.save
      render plain: user.id
    else
      render :status => 404
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email)
  end
end
