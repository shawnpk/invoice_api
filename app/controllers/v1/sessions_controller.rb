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
      if nilify_token && current_user.save
        head :ok
      else
        head :unauthorized
      end
    end

    private
      def nilify_token
        current_user&.authentication_token = nil
      end
  end
end
