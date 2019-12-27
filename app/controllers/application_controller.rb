class ApplicationController < ActionController::Base

  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      flash[:danger] = '権限がありません'
      redirect_to login_url
    end
  end
end
