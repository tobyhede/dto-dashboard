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

    context 'when unauthorised' do
      before { get :show, :params => { :dataset_id => 999, :id => 999 } }
      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      let(:dataset)     { dashboard.datasets.first }
      let(:datapoint)   { dataset.datapoints.first }

      let(:schema)      { datapoint_schema }

      context 'with unowned dataset' do
        before { get :show, :params => { :dataset_id => 999, :id => 999 } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with unowned datapoint' do
        before { get :show, :params => { :dataset_id => dataset.id, :id => 999 } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with datapoint and widget' do
        before { get :show, :params => { :dataset_id   => dataset.id, :id => datapoint.id } }

        include_examples 'api_authorized_ok'
      end

    end
  end

  describe '#create' do
    let(:schema)    { datapoint_schema }
    let(:dataset)   { dashboard.datasets.first }
    let(:datapoint) { dataset.datapoints.first }

    context 'when unauthorised' do
      before { post :create, :params => { :dataset_id => 999 } }
      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with unowned dataset' do
        before { post :create, :params => { :dataset_id => 999 } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with dataset and datapoint' do
        let(:status) { 201 }

        before { post :create, :params => { :dataset_id => dataset.id, :ts => Time.zone.now, :value => 42 } }

        include_examples 'api_authorized_status_and_schema'
      end

      context 'with dataset and an array of datapoints' do
        let(:status) { 201 }
        let(:schema) { datapoints_schema }

        # let!(:dataset) { FactoryGirl.create(:dataset, :user => user) }

        before { post :create, :params => { :dataset_id => dataset.id, :datapoints => [{:ts => Time.zone.now, :value => 42},{:ts => Time.zone.now, :value => 11}] } }

        include_examples 'api_authorized_status_and_schema'

        it { expect(dataset.datapoints.count).to eq 12  }
      end


      context 'with dataset and invalid datapoint' do
        let(:status) { 400 }
        let(:schema) { error_schema }

        before { post :create, :params => { :dataset_id => dataset.id, :value => 42 } }

        include_examples 'api_authorized_status_and_schema'
      end
    end
  end

  describe '#update' do
    let(:schema)      { datapoint_schema }

    let(:dataset)   { dashboard.datasets.first }
    let(:datapoint) { dataset.datapoints.first }

    context 'when unauthorised' do
      before { put :update, :params => { :dataset_id => 999, :id => 42 } }
      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with unowned dataset' do
        before { put :update, :params => { :dataset_id => 999, :id => 42 } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with unowned dataset' do
        before { put :update, :params => { :dataset_id => dataset.id, :id => 42 } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with dataset and datapoint' do

        before { put :update, :params => { :dataset_id => dataset.id, :id => datapoint.id, :value => 42 } }

        it { expect(datapoint.reload.value).to eq 42 }

        include_examples 'api_authorized_ok'
      end

      context 'with dataset and invalid data' do
        let(:status) { 400 }
        let(:schema) { error_schema }

        before { post :create, :params => { :dataset_id => dataset.id, :id => datapoint.id, :ts => 42 } }

        include_examples 'api_authorized_status_and_schema'
      end
    end
  end

end
