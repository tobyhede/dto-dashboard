require "rails_helper"

RSpec.describe DashboardsController, :type => :controller do

  describe "GET index page" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

  end

  # Please uncomment the following test when the test data is imported to the test database
  describe "GET show page with a valid dashboard id" do
    let(:dashboard)    { FactoryGirl.create(:dashboard) }
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
end
