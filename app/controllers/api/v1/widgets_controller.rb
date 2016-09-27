class Api::V1::WidgetsController < Api::V1::ApiController

  def index
    begin
      dashboard = current_user.dashboards.find(params[:dashboard_id])
      render :json => dashboard.widgets.by_name.to_json
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def show
    begin
      dashboard = current_user.dashboards.find(params[:dashboard_id])
      widget = dashboard.widgets.find(params[:id])
      render :json => widget.to_json
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def update
    begin
      dashboard = current_user.dashboards.find(params[:dashboard_id])
      widget = dashboard.widgets.find(params[:id])
      widget.update_attributes!(widget_data)
      render :json => widget.to_json, :status => :ok
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
    rescue ActiveRecord::RecordNotFound
      head :not_found
    rescue ActiveSupport::JSON.parse_error
      head :bad_request
    end
  end

  private

  def widget_data
    data = ActiveSupport::JSON.decode(params[:widget])
    data.slice(*%w{name description units last_updated_at})
  end
  
end
