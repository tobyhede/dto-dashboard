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
    begin
      datapoint = dataset.datapoints.create!(datapoint_data)
      render :json => datapoint, :status => :created
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
    end
  end

  def update
    begin
      datapoint.update_attributes!(datapoint_data)
      render :json => datapoint, :status => :ok
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
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

  def datapoint_data
    data = ActiveSupport::JSON.decode(params[:datapoint])
    data.slice('ts', 'value')
  end

end
