require "rails_helper"

RSpec.describe Api::V1::DatapointsController, :type => :controller do

  # before { FactoryGirl.create(:dataset_with_datapoints) }

  # describe "#index" do
  #   before { get :index }
  #   it     { expect(response).to be_success }
  #   it     { expect(response).to have_http_status(200) }
  # end

  describe "#create" do

    let(:dataset) { FactoryGirl.create(:dataset) }
    let(:params) { FactoryGirl.attributes_for(:datapoint) }

    before { post :create, params.merge(:dataset_id => dataset.id) }

    it 'creates a datapoint' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(Dataset).to have(1).record
    end
  end


end
