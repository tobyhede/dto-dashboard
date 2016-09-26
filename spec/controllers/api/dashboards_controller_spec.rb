require "rails_helper"

RSpec.describe Api::V1::DashboardsController, :type => :controller do
  include_context 'api_schema'

  describe "#index" do

    context 'when unauthorised' do
      before { get :index }
      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with valid dashboard' do

        let(:schema)  { dashboards_schema }

        before do
          user.dashboards << FactoryGirl.create(:dashboard_with_widgets)
          get :index
        end

        include_examples 'api_authorized_ok'
      end
    end

  end

  describe "#show" do
    context 'when unauthorised' do
      before { get :index, :params => { :id => 42 } }
      include_examples 'api_unauthorized_examples'
    end
  end

  describe "#update" do

    context 'when unauthorised' do
      before { get :index, :params => { :id => 42 } }
      include_examples 'api_unauthorized_examples'
    end

    context 'when authorised' do
      include_context 'api_authorisation'

      context 'with unowned dashboard' do
        let(:other) { FactoryGirl.create(:dashboard_with_widgets) }
        before { put :update, :params => { :id => other.id } }
        it { expect(response).to have_http_status(404) }
      end

      context 'with bad input' do
        before { put :update, :params => { :id => dashboard.id, :dashboard => 'VTHA: 18' } }
        it { expect(response).to have_http_status(400) }
      end

      context 'with valid dashboard' do
        let(:status)  { 200 }
        let(:schema)  { dashboard_schema }

        let(:attributes) { { :name => 'Vtha' } }
        before { put :update, :params => { :id => dashboard.id, :dashboard => ActiveSupport::JSON.encode(attributes) } }

        it { expect(dashboard.reload.name).to eq 'Vtha' }
        include_examples 'api_authorized_status_and_schema'
      end

    end


  end

end
