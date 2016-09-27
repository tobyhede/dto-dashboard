class Api::V1::DashboardsController < Api::V1::ApiController

  def index
    dashboards = current_user.dashboards.by_name.all
    render :json => dashboards    
  end

  def show
    begin
      dashboard = current_user.dashboards.find(params[:id])
      render :json => dashboard
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def update
    begin
      dashboard = current_user.dashboards.find(params[:id])
      dashboard.update_attributes!(dashboard_data)
      render :json => dashboard, :status => :ok
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
    rescue ActiveRecord::RecordNotFound
      head :not_found
    rescue ActiveSupport::JSON.parse_error
      head :bad_request
    end
  end

  private

  def dashboard_data
    data = ActiveSupport::JSON.decode(params[:dashboard])
    data.slice(*%w{name description target_users notes url published_at})
  end

end
