require 'rails_helper'

RSpec.describe DashboardDecorator, type: :decorator do

  describe '.recorded_at' do
    it 'works' do
      widget = create(:widget_with_datasets)

      puts widget.as_json(:include => {
        :datasets => {
          :include => :datapoints
        }
      })
    end
  end

end
