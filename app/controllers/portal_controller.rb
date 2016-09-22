class PortalController < ApplicationController

  before_action :authenticate_user!
  helper_method :session_token

  protected

  def index
    render :index
  end

  def session_token
    current_user.session_token
  end
end
