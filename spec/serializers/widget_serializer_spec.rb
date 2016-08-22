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
  it { is_expected.to include('description') }
  it { is_expected.to include('updated_at') }
  it { is_expected.to include('datasets') }


  describe 'dataset' do
    subject(:dataset) { data['datasets'].first }

    it {
      puts dataset
    }

    it { should include('id') }
    it { should include('datapoints') }

    describe 'datapoint' do
      subject(:datapoint) { dataset['data'].first }
      it { is_expected.to include('label') }
      it { is_expected.to include('value') }
    end
  end

    {
      "suffix": "%",
      "latest": {
        "label": "2016-06",
        "value": 97
      },
      "change": 7,
      "summary": "Up by undefined7.0% since 2016-05",
      "id": "user-satisfaction",
      "name": "User Satisfaction",
      "size": "extra-small",
      "type": "kpi-sparkline",
      "units": "%",
      "datasets": [{
        "id": "user-satisfaction",
        "data": [{
          "label": "2016-03",
          "value": 99
        }, {
          "label": "2016-04",
          "value": 95
        }, {
          "label": "2016-05",
          "value": 90
        }, {
          "label": "2016-06",
          "value": 97
        }],
        "name": "User satisfaction",
        "note": "",
        "color": "#f0f0f0",
        "units": "",
        "recorded_at": "2016-06-30T01:01:01.111Z"
      }],
      "updated_at": "2016-06-30T01:01:01.111Z",
      "description": "Overall satisfaction score includes all ratings weighted from 100% for very satisfied to 0% for very dissatisfied"
    }

end
