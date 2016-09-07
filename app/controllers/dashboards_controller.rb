class DashboardsController < AuthenticatedController

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

  def export
    @dashboard = Dashboard.find(params[:id])

    respond_to do |format|
      format.csv { send_data DashboardCSVSerializer.new(@dashboard).to_csv, :type => 'text/csv', :disposition=>'attachment', :filename=>'dashboard.csv' }
    end
  end
end
