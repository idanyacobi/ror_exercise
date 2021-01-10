class UsersController < ApplicationController

  before_action :set_user,
                except: %i[
                  index
                  create
                  sign_in
                  sign_out
                ]

  before_action :authenticate,
                except: %i[
                  index
                  create
                  sign_in
                  sign_out
                  show
                ]

  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render :json => { :errors => @user.errors.full_messages }, :status => 400
    end
  end

  def sign_in
    @user = ::Services::UserService::sign_in login_params
    if @user
      cookies["token"] = {
        value: @user.token
      }
      render json: @user
    else
      render :json => { :errors => @user.errors.full_messages }, :status => 401
    end
  end

  def sign_out
    user = User.find_by(token: request.headers[:token])
    if ::Services::UserService::sign_out user
      render :plain => "User signed out successfully", :status => 200
    else
      render :json => { :errors => user.errors.full_messages }, :status => 400
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render :json => { :errors => @user.errors.full_messages }, :status => 400
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  private
  def authenticate
    if @user.token != request.headers[:token]
      render :json => { :errors => "User unauthenticated" }, :status => 401
    end
  end

  private
  def login_params
    params.permit(:email, :password)
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
