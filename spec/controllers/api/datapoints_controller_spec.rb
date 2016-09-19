require "rails_helper"

RSpec.describe Api::V1::DatapointsController, :type => :controller do

  # describe "#index" do
  #   before { get :index }
  #   it     { expect(response).to be_success }
  #   it     { expect(response).to have_http_status(200) }
  # end

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

    context 'with valid token and dataset' do
      let(:user)        { FactoryGirl.create(:user_with_token) }
      let(:dashboard)   { FactoryGirl.create(:dashboard_with_widgets) }
      let(:dataset)     { dashboard.datasets.first }
      let(:datapoint)   { FactoryGirl.create(:datapoint, :dataset => dataset) }

      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

      before do
        user.dashboards << dashboard
        request.env["HTTP_AUTHORIZATION"] = authorization
        get :show, :params => { :dataset_id => dataset.id, :id => datapoint.id }
      end

      it 'returns the datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(response.body).to include("{\"id\":#{datapoint.id}")
      end
    end

    context 'with valid token and invalid dataset' do
      let(:user)            { FactoryGirl.create(:user_with_token) }
      let(:dataset)         { FactoryGirl.create(:dataset) }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        get :show, :params => { :dataset_id => dataset.id, :id => 999 }
      end

      it 'should not be found' do
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
      let(:dashboard)   { FactoryGirl.create(:dashboard_with_widgets) }
      let(:user)        { FactoryGirl.create(:user_with_token, :dashboards => [dashboard]) }
      let(:dataset)     { dashboard.datasets.first }

      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

      let(:params)      { { :dataset_id => dataset.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'creates a datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(201)
      end
    end

    context 'with valid token and invalid dataset' do
      let(:dataset)         { FactoryGirl.create(:dataset) }
      let(:dashboard)       { FactoryGirl.create(:dashboard_with_widgets) }
      let(:user)            { FactoryGirl.create(:user_with_token, :dashboards => [dashboard]) }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

      let(:params)      { { :dataset_id => dataset.id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'should not be found' do
        expect(response).to have_http_status(404)
      end
    end

    context 'with bad input' do
      let(:dashboard)       { FactoryGirl.create(:dashboard_with_widgets) }
      let(:dataset)         { dashboard.datasets.first }
      let(:user)            { FactoryGirl.create(:user_with_token, :dashboards => [dashboard]) }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(user.token) }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => { :dataset_id => dataset.id, :datapoint => 'blah' }
      end

      it 'should be a bad_request' do
        expect(response).to have_http_status(400)
      end
    end

  end


end
