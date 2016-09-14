require "rails_helper"

RSpec.describe Api::V1::DatapointsController, :type => :controller do

  # describe "#index" do
  #   before { get :index }
  #   it     { expect(response).to be_success }
  #   it     { expect(response).to have_http_status(200) }
  # end

  describe "#create" do
    let(:attributes)  { FactoryGirl.attributes_for(:datapoint) }
    let(:dataset_id)  { 999 }

    let(:params)      { { :dataset_id => dataset_id, :datapoint => ActiveSupport::JSON.encode(attributes) } }

    context 'without auth token' do
      before { post :create, :params => params }
      it 'unauthorized' do
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid auth token' do
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
      let(:dataset)         { FactoryGirl.create(:dataset_with_token) }
      let(:dataset_id)      { dataset.id }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(dataset.token) }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'creates a datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(201)
        expect(Dataset).to have(1).record
      end
    end

    context 'with valid token and invalid dataset' do
      let(:dataset)         { FactoryGirl.create(:dataset_with_token) }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(dataset.token) }

      before do
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'should not be found' do
        expect(response).to have_http_status(404)
      end
    end

    context 'with bad input' do
      let(:dataset)         { FactoryGirl.create(:dataset_with_token) }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(dataset.token) }

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
