require "rails_helper"


RSpec.describe Api::V1::DatapointsController, :type => :controller do
  include_context 'api_schema'

  describe 'index' do

    context 'when unauthorised' do
      let(:params) { { :dataset_id => 999 } }
      before { get :index, :params => params }

      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with unknown dataset' do
        let(:dataset) { FactoryGirl.create(:dataset) }
        before { get :index, :params => { :dataset_id => dataset.id } }

        include_examples 'api_authorized_not_found'
      end

      context 'with dashboard' do
        include_context 'api_schema'

        let(:dataset) { dashboard.datasets.first }
        let(:schema)  { datapoints_schema }

        before { get :index, :params => { :dataset_id => dataset.id } }

        include_examples 'api_authorized_ok'
      end
    end
  end

  describe "#show" do

    context 'without auth token' do
      before { get :show, :params => { :dataset_id => 999, :id => 999 } }

      it 'unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid auth token' do
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials('blahvtha') }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        get :show, :params => { :dataset_id => 999, :id => 999 }
      end

      it 'unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with valid token, dataset and datapoint' do
      include_context 'api_authorisation'
      include_context 'api_schema'

      let(:dataset)     { dashboard.datasets.first }
      let(:datapoint)   { dataset.datapoints.first }

      before do
        get :show, :params => { :dataset_id => dataset.id, :id => datapoint.id }
      end

      it 'is ok' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      it 'returns a valid datapoint' do
        expect(response.body).to validate_as_schema(datapoint_schema)
      end
    end

    context 'with valid token and invalid dataset' do
      include_context 'api_authorisation'

      let(:dataset) { FactoryGirl.create(:dataset) }

      before { get :index, :params => { :dataset_id => dataset.id } }

      it 'should not be found' do
        expect(response).to have_http_status(404)
      end
    end

    context 'with valid token, dataset and invalid datapoint' do
      include_context 'api_authorisation'

      let(:dataset)     { dashboard.datasets.first }
      let(:datapoint)   { FactoryGirl.create(:datapoint) }

      before do
        get :show, :params => { :dataset_id => dataset.id, :id => datapoint.id }
      end

      it 'returns the datapoint' do
        expect(response).to have_http_status(404)
      end
    end
  end


  describe "#create" do
    let(:attributes)  { FactoryGirl.attributes_for(:datapoint) }

    context 'without auth token' do
      let(:params)      { { :dataset_id => 999, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      it 'unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid auth token' do
      let(:params)          { { :dataset_id => 999, :datapoint => ActiveSupport::JSON.encode(attributes) } }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials('blahvtha') }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with valid token and dataset' do
      include_context 'api_authorisation'

      let(:dataset)   { dashboard.datasets.first }
      let(:params)    { { :dataset_id => dataset.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      it 'creates a datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(201)
      end
    end

    context 'with valid token and missing timestamp' do
      include_context 'api_authorisation'

      let(:attributes)  { { :value => nil } }
      let(:dataset)     { dashboard.datasets.first }
      let(:params)      { { :dataset_id => dataset.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      it 'creates a datapoint' do
        expect(response).to_not be_success
        expect(response.body).to include('RecordInvalid')
        expect(response.body).to include('Validation failed')
        expect(response.body).to include('Ts can\'t be blank')
      end
    end

    context 'with invalid datapoint' do
      include_context 'api_authorisation'

      let(:status)      { 400 }
      let(:schema)      { error_schema }
      let(:attributes)  { { :value => nil } }

      let(:params)      { { :dataset_id => dashboard.datasets.first.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      include_examples 'api_authorized_status_and_schema'
    end

    context 'with valid datapoint' do
      include_context 'api_authorisation'

      let(:status)  { 201 }
      let(:schema)  { datapoint_schema }

      let(:params)    { { :dataset_id => dashboard.datasets.first.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      include_examples 'api_authorized_status_and_schema'
    end


    context 'with valid token and invalid dataset' do
      include_context 'api_authorisation'

      let(:dataset) { FactoryGirl.create(:dataset) }

      let(:params)  { { :dataset_id => dataset.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before { post :create, :params => params }

      it 'should not be found' do
        expect(response).to have_http_status(404)
      end
    end

    context 'with bad input' do
      include_context 'api_authorisation'

      let(:dataset) { dashboard.datasets.first }

      let(:params)  { { :dataset_id => dataset.id, :datapoint => 'blah' } }

      before { post :create, :params => params }

      it 'should be a bad_request' do
        expect(response).to have_http_status(400)
      end
    end

  end


end
