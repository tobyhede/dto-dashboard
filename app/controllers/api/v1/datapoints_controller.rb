class Api::V1::DatapointsController < ActionController::API

  def index
    render :json => []
  end

  def create
    puts params.inspect
    dataset = Dataset.find(params[:dataset_id])
    dataset.datapoints.create!(datapoint_params)
    render :json => { :status => 'ok' }
  end

  private
  def datapoint_params
    params.permit(:ts, :value)
  end

end
