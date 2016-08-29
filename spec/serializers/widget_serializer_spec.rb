require 'rails_helper'

RSpec.describe WidgetSerializer, type: :serializer do

  let(:widget) { FactoryGirl.create(:widget_with_datasets) }
  let(:serializer)  { WidgetSerializer.new(widget, :include => 'datasets.datapoints') }

  subject(:data)    { JSON.parse(serializer.to_json) }

  it { is_expected.to include('id') }
  it { is_expected.to include('name') }
  it { is_expected.to include('size') }
  it { is_expected.to include('type') }
  it { is_expected.to include('units') }
  it { is_expected.to include('latest') }
  it { is_expected.to include('description') }
  it { is_expected.to include('definition') }
  it { is_expected.to include('updated_at') }
  it { is_expected.to include('datasets') }
  it { is_expected.to include('prefix') }
  it { is_expected.to include('suffix') }

  it { expect(data['definition']).to eq data['description']}

  describe '#latest' do
    subject(:latest) { data['latest'] }
    it { is_expected.to include('label') }
    it { is_expected.to include('value') }
  end

  describe 'dataset' do
    subject(:dataset) { data['datasets'].first }

    it { should include('id') }
    it { should_not include('datapoints') }

    describe 'datapoint' do
      subject(:datapoint) { dataset['data'].first }
      it { is_expected.to include('label') }
      it { is_expected.to include('value') }
    end
  end

end
