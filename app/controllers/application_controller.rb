class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :authorized?

  PUBLIC_CONTROLLERS = %w[home sessions].freeze

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def authorized?
    redirect_to root_path unless allowed_to_visit?
  end

  private

  def allowed_to_visit?
    public_page? || action_allowed?
  end

  def public_page?
    PUBLIC_CONTROLLERS.include?(controller_name)
  end

  def action_allowed?
    logged_in? && role_has_permission?
  end

  def logged_in?
    return true unless current_user.nil?

    flash[:notice]             = 'You must log in to see this page.'
    session[:orig_destination] = request.path
    false
  end

  def role_has_permission?
    return true
    permission = current_user&.role&.permissions.select { |p| p.feature.name == controller_name }
    permission.first&.actions&.select{|a| a.name == action_name}&.any? || false
  end
end
