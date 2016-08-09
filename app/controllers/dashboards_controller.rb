class DashboardsController < ApplicationController

  attr_reader :dashboards
  helper_method :dashboards

  def index
    @dashboards = Dashboard.published.by_name.all.decorate
    render :index
  end
end
