module V1
  class SessionsController < ApplicationController
    def show
      current_user ? head(:ok) : head(:unauthorized)
    end

    def create
      @user = User.find_by(email: params[:email])

      if @user&.authenticate(params[:password])
        token = JWT.encode({ user_id: @user.id, 
                             exp: (24.hours.from_now).to_i}, 
                             Rails.application.credentials.secret_key_base)
        render json: token, status: :created
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
        current_user&.token = nil
      end
  end
end
