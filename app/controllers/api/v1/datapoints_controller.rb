class Api::V1::DatapointsController < ActionController::API

  attr_reader :dataset

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def index
    render :json => []
  end

  def create
    begin
      datapoint = dataset.datapoints.create!(datapoint_data)
      render :json => { :id => datapoint.id }, :status => :created
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  private

  def datapoint_data
    data = ActiveSupport::JSON.decode(params[:datapoint])
    data.slice('ts', 'value')
  end
  
  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @dataset = Dataset.authenticate(token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: :unauthorized
  end
end
