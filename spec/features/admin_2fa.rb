require 'rails_helper'
require 'devise'

RSpec.describe 'two-factor auth', :type => :feature do
  include Devise::Test::IntegrationHelpers

  let!(:admin_user) { FactoryGirl.create :user_confirmed }
  let!(:editor_user) { FactoryGirl.create :user_confirmed }

  describe 'enabling' do
    before do
      sign_in admin_user
      visit admin_user_path editor_user
      click_link 'Enable 2FA'
    end

    it 'should show a QR code' do
      qr_path = qr_image_admin_user_path(editor_user)
      expect(page).to have_xpath "//img[@src=\"#{qr_path}\"]"
    end

    # n.b. No point testing actual 2FA flow as we would be testing the library not Dashboard
  end
end
