class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :require_login!

  def require_login!
    return true if authenticate_api_token

    render json: { status: 'error', message: 'Access Denied' }, status: :unauthorized
  end

  def current_user
    @current_user ||= authenticate_api_token
  end

  protected

  def authenticate_api_token
    authenticate_with_http_token do |token, options|
      User.find_by(api_token: token)
    end
  end
end
