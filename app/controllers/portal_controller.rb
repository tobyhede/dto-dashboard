class PortalController < ApplicationController

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: []

  protected

  def configure_permitted_parameters
  end

  def index
    render :index
  end

end
