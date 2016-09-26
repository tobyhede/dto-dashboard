class Api::V1::DatapointsController < Api::V1::ApiController

  def index
    begin
      dataset = current_user.datasets.find(params[:dataset_id])
      render :json => dataset.datapoints.by_time.limit(999)
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def show
    begin
      dataset = current_user.datasets.find(params[:dataset_id])
      datapoint = dataset.datapoints.find(params[:id])
      render :json => datapoint
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def create
    begin
      dataset = current_user.datasets.find(params[:dataset_id])
      datapoint = dataset.datapoints.create!(datapoint_data)
      render :json => datapoint, :status => :created
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
    rescue ActiveRecord::RecordNotFound
      head :not_found
    rescue ActiveSupport::JSON.parse_error
      head :bad_request
    end
  end

  private

  def datapoint_data
    data = ActiveSupport::JSON.decode(params[:datapoint])
    data.slice('ts', 'value')
  end

end
