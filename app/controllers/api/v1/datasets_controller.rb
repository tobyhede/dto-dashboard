class Api::V1::DatasetsController < Api::V1::ApiController

  before_action :find_dataset, :only => [:show, :update]
  attr_reader :dataset

  def index
    datasets = current_user.datasets.by_name.all
    render :json => datasets.to_json
  end

  def show
    render :json => dataset.to_json
  end

  def update
    begin
      dataset.update_attributes!(dataset_data)
      render :json => dataset.to_json, :status => :ok
    rescue ActiveRecord::RecordInvalid => e
      render :json => { :code => 'RecordInvalid', :message => e.message}, :status => :bad_request
    rescue ActiveRecord::RecordNotFound
      head :not_found
    rescue ActiveSupport::JSON.parse_error
      head :bad_request
    end
  end

  private

  def find_dataset
    begin
      @dataset = current_user.datasets.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def dataset_data
    data = ActiveSupport::JSON.decode(params[:dataset])
    data.slice(*%w{name label units})
  end

end
