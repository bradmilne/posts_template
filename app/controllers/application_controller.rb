class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user, :logged_in?, :admin_or_current_user, :not_yet_voted

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?   
  end

  def access_denied
    flash[:error] = "You can't do that"
    redirect_to root_path
  end

  def not_yet_voted(voteable_object)
    true unless voteable_object.votes.where(user_id: current_user.id).size != 0
  end

  def admin_or_current_user
    access_denied unless logged_in? || current_user.admin?  
  end


end
