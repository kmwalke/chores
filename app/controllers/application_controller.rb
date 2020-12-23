class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :authorized?

  PUBLIC_CONTROLLERS = %w[home sessions].freeze

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorized?
    redirect_to root_path unless allowed_to_visit?
  end

  private

  def allowed_to_visit?
    public_page? || request_allowed?
  end

  def public_page?
    PUBLIC_CONTROLLERS.include?(controller_name)
  end

  def request_allowed?
    logged_in? && permission?
  end

  def logged_in?
    return true unless current_user.nil?

    flash[:notice]             = 'You must log in to see this page.'
    session[:orig_destination] = request.path
    false
  end

  def permission?
    permission&.actions&.select { |a| a.name == action_name }&.any? || false
  end

  def permission
    current_user&.role&.permissions&.select { |p| p.feature.name == controller_name }&.first
  end
end
