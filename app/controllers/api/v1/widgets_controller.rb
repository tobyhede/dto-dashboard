class Api::V1::WidgetsController < Api::V1::ApiController

  before_action :find_dashboard
  before_action :find_widget, :only => [:show, :update]

  attr_reader :dashboard, :widget

  def index
    render :json => dashboard.widgets.by_name.to_json
  end

  def show
    render :json => widget.to_json
  end

  def update
    with_invalid_record_handler do
      widget.update_attributes!(data)
      render :json => widget.to_json, :status => :ok
    end
  end

  private

  def find_dashboard
    begin
      @dashboard = current_user.dashboards.find(params[:dashboard_id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def find_widget
    begin
      @widget = dashboard.widgets.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def data
    params.permit(:name, :description, :units, :last_updated_at)
  end

end
