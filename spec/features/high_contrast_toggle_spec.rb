require 'rails_helper'

RSpec.describe "high contrast mode toggle", :type => :feature, :js => true do
  # visit '/dashboards/2-australian-citizenship-appointment-booking-service-dashboard'
  # page.check('switch-mode')
  # page.should have_css('body.is-high-contrast')

  context 'a user should be able to change the contrast of the dashboard pages' do
    let(:dashboard)    { FactoryGirl.create(:dashboard_published) }

    it 'should show toggle switch' do
      visit(dashboard_path(dashboard))
      page.has_css?('div.toggle-switch')
    end
  end
end
