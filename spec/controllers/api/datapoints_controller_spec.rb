require "rails_helper"

RSpec.describe Api::V1::DatapointsController, :type => :controller do

  describe 'index' do
    context 'when unauthorised' do

      context 'without token' do
        before { get :index, :params => { :dataset_id => 999 } }
        it 'returns unauthorized' do
          expect(response).to have_http_status(401)
        end
      end

      context 'with invalid token' do
        let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials('blahvtha') }

        before do
          request.env["HTTP_AUTHORIZATION"] = authorization
          get :index, :params => { :dataset_id => 999 }
        end

        it 'returns unauthorized' do
          expect(response).to have_http_status(401)
        end
      end
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with valid token and invalid dataset' do
        let(:dataset) { FactoryGirl.create(:dataset) }

        before { get :index, :params => { :dataset_id => dataset.id } }

        it 'returns datapoints' do
          expect(response).to have_http_status(404)
        end
      end

      context 'with valid token and dataset' do

        let(:dataset) { dashboard.datasets.first }

        before { get :index, :params => { :dataset_id => dataset.id } }

        it 'returns datapoints' do
          expect(response).to be_success
          expect(response).to have_http_status(200)
          dataset.datapoints.each do |datapoint|
            expect(response.body).to include datapoint_json(datapoint)
          end
        end
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

      let(:dataset)     { dashboard.datasets.first }
      let(:datapoint)   { dataset.datapoints.first }

      before do
        get :show, :params => { :dataset_id => dataset.id, :id => datapoint.id }
      end

      it 'returns the datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response.body).to include datapoint_json(datapoint)
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
