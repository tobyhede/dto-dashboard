require 'rails_helper'
require 'devise'

RSpec.describe EditorController, :type => :controller do

  describe 'log into the controller' do
    login_user

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get index page successfully" do
      get :index
      expect(response).to be_success
    end
  end

  describe "log out from the controller" do
    logout_user

    it "should not have a current_user" do
      expect(subject.current_user).to eq(nil)
    end

    it "should get index page unsuccessfully" do
      get :index
      expect(response).to_not be_success
    end
  end
end
