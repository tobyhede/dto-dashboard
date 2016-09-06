require 'rails_helper'

RSpec.describe "high contrast mode toggle", :type => :feature, :js => true do

  context 'a user should be able to change the contrast of the dashboard pages' do
    let(:dashboard)    { FactoryGirl.create(:dashboard_published) }

    it 'should show toggle switch' do
      visit(dashboard_path(dashboard))
      page.has_css?('div.toggle-switch')
    end
  end
end
