require "rails_helper"

RSpec.describe DashboardsController, :type => :controller do
  login_user

  it "should have a current_user" do
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET index page" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

  end

  describe "GET show page with a valid dashboard id" do
    let(:dashboard)    { FactoryGirl.create(:dashboard_published) }
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: dashboard.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

  end

  describe "GET show page with an invalid dashboard id" do
    it "should catch an exception" do
      expect {
        get :show, params: {id: 10000}
      }.to raise_error ActiveRecord::RecordNotFound

    end

  end

  describe "Export the csv data" do
    context "with a valid dashboard id" do
      let(:opts) { {} }
      let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, opts) }
      it "responds successfully with an HTTP 200 status code" do
        get :export, params: {id: dashboard.id, format: 'csv' }
        expect(response).to be_success
      end
    end
  end
end
