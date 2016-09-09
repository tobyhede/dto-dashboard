class DashboardsController < ApplicationController

  attr_reader :dashboards, :dashboard, :widgets
  helper_method :dashboards, :dashboard

  def index
    @dashboards = Dashboard.published.by_name.all.decorate

    render :index
  end

  def show
    @dashboard = Dashboard.find(params[:id]).decorate
    
    @title = @dashboard.name
    @description = @dashboard.name

    render :show
  end
end
