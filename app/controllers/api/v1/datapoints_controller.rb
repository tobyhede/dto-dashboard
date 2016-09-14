class Api::V1::DatapointsController < ActionController::API

  attr_reader :token

  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def index
    render :json => []
  end

  def show
    begin
      dataset = token.datasets.find(params[:dataset_id])
      datapoint = dataset.datapoints.find(params[:id])
      render :json => datapoint
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def create
    begin
      dataset = token.datasets.find(params[:dataset_id])
      datapoint = dataset.datapoints.create!(datapoint_data)
      render :json => datapoint, :status => :created
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

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      @token = Token.authenticate(token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: :unauthorized
  end
end
