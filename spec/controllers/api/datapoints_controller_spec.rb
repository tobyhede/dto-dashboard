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

    context 'with dataset and token' do
      let(:dataset)         { FactoryGirl.create(:dataset_with_token) }
      let(:dataset_id)      { dataset.id }
      let(:authorization)   { ActionController::HttpAuthentication::Token.encode_credentials(dataset.token) }

      before do
        puts attributes
        request.env["HTTP_AUTHORIZATION"] = authorization
        post :create, :params => params
      end

      it 'creates a datapoint' do
        expect(response).to be_success
        expect(response).to have_http_status(201)
        expect(Dataset).to have(1).record
      end

      # context 'with invalid dataset id' do
      #   it 'returns 404'  do
      #     expect(response).to have_http_status(404)
      #     expect(Dataset).to have(0).records
      #   end
      # end

      # context 'when the organisation does not own dataset' do
      #   let(:dataset_id) { FactoryGirl.create(:dataset).id }
      #
      #   it 'should be unauthorized' do
      #     expect(response).to have_http_status(404)
      #   end
      # end

    end

  end


end
