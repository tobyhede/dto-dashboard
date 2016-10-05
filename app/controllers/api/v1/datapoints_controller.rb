class Api::V1::DatapointsController < Api::V1::ApiController

  before_action :find_dataset
  before_action :find_datapoint, :only => [:show, :update]

  attr_reader :dataset, :datapoint

  def index
    render :json => dataset.datapoints.by_time.limit(999)
  end

  def show
    render :json => datapoint.to_json
  end

  def create
    with_invalid_record_handler do
      datapoint = dataset.datapoints.create!(data)
      render :json => datapoint.to_json, :status => :created
    end
  end

  def update
    with_invalid_record_handler do
      datapoint.update_attributes!(data)
      render :json => datapoint.to_json, :status => :ok
    end
  end

  private

  def find_dataset
    begin
      @dataset = current_user.datasets.find(params[:dataset_id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def find_datapoint
    begin
      @datapoint = dataset.datapoints.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def data
    if datapoints?
      data = params.permit(:datapoints => [:ts, :value])
      data[:datapoints]
    else
      params.permit(:ts, :value)
    end
  end

  def datapoints?
    params[:datapoints].present?
  end

end
