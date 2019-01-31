module V1
  class SessionsController < ApplicationController
    def show
      current_user ? head :ok : head :unauthorized
    end

    def create
      @user = User.find_by!(email: params[:email])

      if @user&.authenticate(params[:password])
        render json: @user.as_json(only: %i[id]), status: :created
      else
        head :unauthorized
      end
    end

    def destroy
      current_user&.authenticate_token = nil

      if current_user.save
        head :ok
      else
        head :unauthorized
      end
    end
  end
end
