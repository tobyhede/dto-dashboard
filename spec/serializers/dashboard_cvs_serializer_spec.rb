require 'rails_helper'
require 'csv'

RSpec.describe DashboardCSVSerializer, type: :serializer do

  let(:opts) { {} }
  let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, opts) }
  subject(:serializer) { DashboardCSVSerializer.new(dashboard) }

  describe 'has CSV data test' do
    it do
      expect( serializer.to_csv ).not_to eq be_empty
    end

  end

  describe 'data format test' do
      # This test case should be failed if the data format from the DashboardCSVSerializer.csv method is not CSV
    it do
      csv = serializer.to_csv
      parser = CSV.parse(csv)
      expect(parser).not_to eq be_empty
      expect(parser.length).to be >= 1  # it should, at least, have a csv header line
      expect(parser[0].length).to be == 5 # data should be with 5 columns

      # check the data items, note that the iteration here will not 100% ensure
      # the data correction, an manual check may still be required if needed
      dashboard.widgets.each do |widget|
        widget.datasets.each do |dataset|

          expect(csv).to include(dataset.name)
          expect(csv).to include(dataset.units)

          dataset.datapoints.each do |datapoint|
            expect(csv).to include(datapoint.ts.strftime("%d/%m/%Y %H:%M"))
            expect(csv).to include(datapoint.label())
            expect(csv).to include(datapoint.value.to_s)
          end
        end
      end

      # parser.each do |row|
      #   puts row.to_s
      # end
    end
  end

  describe "dashboard without widgets test" do
    let(:dashboard) { FactoryGirl.create(:dashboard, opts) }

    it do
      csv = serializer.to_csv
      parser = CSV.parse(csv)
      expect(parser).not_to eq be_empty
      expect(parser.length).to be == 1  # it should contain a csv header line

      expect(parser[0]).to be === ['dataset_name', 'units', 'time_stamp', 'label', 'value']
    end
  end
 end


