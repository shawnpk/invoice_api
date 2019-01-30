class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    users = User.all

    render json: users
  end

  def show
    render json: @user
  end

  def new
    user = User.new(user_params)
  end

  def edit
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render :new
    end
  end

  def update
    @user.update(user_params)

    if @user.save
      render @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    # head :no_content
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
