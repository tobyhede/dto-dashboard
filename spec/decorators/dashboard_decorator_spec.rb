require 'rails_helper'

RSpec.describe DashboardDecorator, type: :decorator do
  
  describe '.recorded_at' do
    it 'works' do
      puts create(:widget_with_datasets).datasets.inspect
    end
  end

end
