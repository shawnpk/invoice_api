module V1
  class SessionsController < ApplicationController
    def create
      @user = User.find_by!(email: params[:email])

      if @user&.authenticate(params[:password])
        render json: @user.as_json(only: %i[id]), status: :created
      else
        head :unauthorized
      end
    end

    def destroy

    end
  end
end
