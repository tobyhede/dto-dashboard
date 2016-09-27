class Api::V1::DatasetsController < Api::V1::ApiController

  def index
    datasets = current_user.datasets.by_name.all
    render :json => datasets.to_json
  end

  def show
    begin
      dataset = current_user.datasets.find(params[:id])
      render :json => dataset.to_json
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def update
    begin
      dataset = current_user.datasets.find(params[:id])
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

  def dataset_data
    data = ActiveSupport::JSON.decode(params[:dataset])
    data.slice(*%w{name label units})
  end

end
