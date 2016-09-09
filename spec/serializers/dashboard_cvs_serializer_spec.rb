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
      # parser.each do |row|
      #   puts row.to_s
      # end
    end
  end

  describe "dashboard without widgets test" do
    let(:empty_dashboard) { FactoryGirl.create(:dashboard, opts) }
    subject(:serializer2) { DashboardCSVSerializer.new(empty_dashboard) }
    it do
      csv = serializer2.to_csv
      parser = CSV.parse(csv)
      expect(parser).not_to eq be_empty
      expect(parser.length).to be == 1  # it should contain a csv header line
    end

  end

end

