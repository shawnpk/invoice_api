class ApplicationController < ActionController::API
  serialization_scope :view_context

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def authorize
    redirect_to '/v1/sessions' unless current_user
  end

  private
    def payload
      JWT.decode(get_token, Rails.application.credentials.secret_key_base).first
    end

    def get_token
      request.headers['Authorization']
    end
    
end
