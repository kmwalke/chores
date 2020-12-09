class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :authorized?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    return true unless current_user.nil?

    flash[:notice]             = 'You must log in to see this page.'
    session[:orig_destination] = request.path
    redirect_to login_path
  end

  def authorized?
    redirect_to login_path unless allowed_to_visit?
  end

  private

  def allowed_to_visit?
    public_page? || action_allowed?
  end

  def public_page?
    public_pages.include?(controller_name)
  end

  def action_allowed?
    logged_in?
  end

  def public_pages
    %w[home sessions]
  end
end
