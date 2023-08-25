class UsersController < ApplicationController
  # GET /users
  before_action :authenticate_admin!
  
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    render json: @user
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'User not found' }, status: :not_found
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { message: 'User not created' }, status: :bad_request
    end
  end

  # PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(**update_user_params)
      render json: { message: 'User updated successfully' }, status: :ok
    else
      render json: { message: 'User not updated' }, status: :bad_request
    end
  end

  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    else
      render json: { message: 'User not deleted' }, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :age, :email)
  end

  def update_user_params
    params.require(:user).permit(:firstname, :lastname, :age, :email)
  end

end