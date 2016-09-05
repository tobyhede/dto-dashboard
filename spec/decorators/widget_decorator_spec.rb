require 'rails_helper'

RSpec.describe WidgetDecorator, type: :decorator do

  let(:latest_value)    { 99 }
  let(:latest_ts)       { Date.parse('2020-02-01') }

  let(:previous_value)  { 99 }
  let(:previous_ts)     { Date.parse('2020-01-01') }

  let(:unit)            { 's' }

  let(:widget)      { FactoryGirl.create(:widget, :last_updated_at => '2020-01-01', :units => unit) }
  let(:dataset)     { FactoryGirl.create(:dataset, :units => unit) }

  let!(:latest)     { FactoryGirl.create(:datapoint, :dataset => dataset, :ts => latest_ts, :value => latest_value) }
  let!(:previous)   { FactoryGirl.create(:datapoint, :dataset => dataset, :ts => previous_ts, :value => previous_value) }

  before {
    widget.datasets << dataset
    widget.save!
  }

  subject { widget.decorate }

  its(:summary)         { is_expected.to eq 'Unchanged since Jan 2020' }
  its(:last_updated_at) { is_expected.to eq '1 Jan 2020'}
  its(:units_to_s)      { is_expected.to eq 'Seconds'}

  describe 'rendering data for charts' do

    let(:widget)  { FactoryGirl.create(:widget_with_datasets) }

    let(:chart)     { widget.decorate.to_chart }
    subject(:data)  { JSON.parse(chart) }

    it { is_expected.to include('id') }
    it { is_expected.to include('name') }
    it { is_expected.to include('units') }
    it { is_expected.to include('latest') }
    it { is_expected.to include('datasets') }

    describe 'dataset' do

      subject(:chart_dataset) { data['datasets'].first }

      it { is_expected.to include('id') }
      it { is_expected.to include('data') }

      describe 'datapoint' do
        subject(:datapoint) { chart_dataset['data'].first }
        it { is_expected.to include('label') }
        it { is_expected.to include('value') }
      end
    end

    describe 'dataset_to_chart' do

      subject(:datasets) { widget.decorate.datasets_to_chart }
      subject(:data)  { JSON.parse(datasets) }

      it { is_expected.to have(2).datasets }
    end


  end

  {
  	"suffix": "%",
  	"latest": {
  		"label": "2016-04",
  		"value": 29
  	},
  	"change": 0,
  	"summary": "Unchanged since 2016-03",
  	"id": "linked-member-services",
  	"name": "Linked Member Services",
  	"size": "medium",
  	"type": "bar",
  	"units": "%",
  	"datasets": [{
  		"id": "links-by-member-service-01",
  		"data": [{
  			"label": "2015-03",
  			"value": 29
  		}, {
  			"label": "2015-04",
  			"value": 29
  		}, {
  			"label": "2015-05",
  			"value": 29
  		}, {
  			"label": "2015-06",
  			"value": 29
  		}, {
  			"label": "2015-07",
  			"value": 29
  		}, {
  			"label": "2015-08",
  			"value": 29
  		}, {
  			"label": "2015-09",
  			"value": 29
  		}, {
  			"label": "2015-10",
  			"value": 29
  		}, {
  			"label": "2015-11",
  			"value": 29
  		}, {
  			"label": "2015-12",
  			"value": 29
  		}, {
  			"label": "2016-01",
  			"value": 29
  		}, {
  			"label": "2016-02",
  			"value": 29
  		}, {
  			"label": "2016-03",
  			"value": 29
  		}, {
  			"label": "2016-04",
  			"value": 29
  		}],
  		"name": "Medicare",
  		"note": "note for this dataset",
  		"color": "#f39841",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}, {
  		"id": "links-by-member-service-02",
  		"data": [{
  			"label": "2015-03",
  			"value": 25
  		}, {
  			"label": "2015-04",
  			"value": 25
  		}, {
  			"label": "2015-05",
  			"value": 26
  		}, {
  			"label": "2015-06",
  			"value": 26
  		}, {
  			"label": "2015-07",
  			"value": 27
  		}, {
  			"label": "2015-08",
  			"value": 27
  		}, {
  			"label": "2015-09",
  			"value": 27
  		}, {
  			"label": "2015-10",
  			"value": 27
  		}, {
  			"label": "2015-11",
  			"value": 27
  		}, {
  			"label": "2015-12",
  			"value": 28
  		}, {
  			"label": "2016-01",
  			"value": 28
  		}, {
  			"label": "2016-02",
  			"value": 28
  		}, {
  			"label": "2016-03",
  			"value": 28
  		}, {
  			"label": "2016-04",
  			"value": 28
  		}],
  		"name": "Centrelink",
  		"note": "note for this dataset",
  		"color": "#fcb639",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}, {
  		"id": "links-by-member-service-03",
  		"data": [{
  			"label": "2015-03",
  			"value": 3
  		}, {
  			"label": "2015-04",
  			"value": 3
  		}, {
  			"label": "2015-05",
  			"value": 3
  		}, {
  			"label": "2015-06",
  			"value": 3
  		}, {
  			"label": "2015-07",
  			"value": 3
  		}, {
  			"label": "2015-08",
  			"value": 3
  		}, {
  			"label": "2015-09",
  			"value": 3
  		}, {
  			"label": "2015-10",
  			"value": 3
  		}, {
  			"label": "2015-11",
  			"value": 3
  		}, {
  			"label": "2015-12",
  			"value": 3
  		}, {
  			"label": "2016-01",
  			"value": 3
  		}, {
  			"label": "2016-02",
  			"value": 3
  		}, {
  			"label": "2016-03",
  			"value": 3
  		}, {
  			"label": "2016-04",
  			"value": 3
  		}],
  		"name": "CSA",
  		"note": "note for this dataset",
  		"color": "#32b0b4",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}, {
  		"id": "links-by-member-service-05",
  		"data": [{
  			"label": "2015-03",
  			"value": 8
  		}, {
  			"label": "2015-04",
  			"value": 8
  		}, {
  			"label": "2015-05",
  			"value": 8
  		}, {
  			"label": "2015-06",
  			"value": 8
  		}, {
  			"label": "2015-07",
  			"value": 7
  		}, {
  			"label": "2015-08",
  			"value": 7
  		}, {
  			"label": "2015-09",
  			"value": 7
  		}, {
  			"label": "2015-10",
  			"value": 7
  		}, {
  			"label": "2015-11",
  			"value": 7
  		}, {
  			"label": "2015-12",
  			"value": 7
  		}, {
  			"label": "2016-01",
  			"value": 7
  		}, {
  			"label": "2016-02",
  			"value": 7
  		}, {
  			"label": "2016-03",
  			"value": 7
  		}, {
  			"label": "2016-04",
  			"value": 7
  		}],
  		"name": "MyHealth",
  		"note": "note for this dataset",
  		"color": "#79be73",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}, {
  		"id": "links-by-member-service-07",
  		"data": [{
  			"label": "2015-03",
  			"value": 34
  		}, {
  			"label": "2015-04",
  			"value": 34
  		}, {
  			"label": "2015-05",
  			"value": 33
  		}, {
  			"label": "2015-06",
  			"value": 33
  		}, {
  			"label": "2015-07",
  			"value": 33
  		}, {
  			"label": "2015-08",
  			"value": 33
  		}, {
  			"label": "2015-09",
  			"value": 33
  		}, {
  			"label": "2015-10",
  			"value": 33
  		}, {
  			"label": "2015-11",
  			"value": 33
  		}, {
  			"label": "2015-12",
  			"value": 33
  		}, {
  			"label": "2016-01",
  			"value": 32
  		}, {
  			"label": "2016-02",
  			"value": 32
  		}, {
  			"label": "2016-03",
  			"value": 31
  		}, {
  			"label": "2016-04",
  			"value": 31
  		}],
  		"name": "ATO",
  		"note": "note for this dataset",
  		"color": "#ea7b49",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}, {
  		"id": "links-by-member-service-09",
  		"data": [{
  			"label": "2015-03",
  			"value": 2
  		}, {
  			"label": "2015-04",
  			"value": 2
  		}, {
  			"label": "2015-05",
  			"value": 2
  		}, {
  			"label": "2015-06",
  			"value": 2
  		}, {
  			"label": "2015-07",
  			"value": 2
  		}, {
  			"label": "2015-08",
  			"value": 2
  		}, {
  			"label": "2015-09",
  			"value": 2
  		}, {
  			"label": "2015-10",
  			"value": 2
  		}, {
  			"label": "2015-11",
  			"value": 3
  		}, {
  			"label": "2015-12",
  			"value": 3
  		}, {
  			"label": "2016-01",
  			"value": 3
  		}, {
  			"label": "2016-02",
  			"value": 3
  		}, {
  			"label": "2016-03",
  			"value": 3
  		}, {
  			"label": "2016-04",
  			"value": 3
  		}],
  		"name": "Other",
  		"note": "Includes DVA, NDIS, JobSearch & MyAgedCare",
  		"color": "#5261c9",
  		"units": "%",
  		"recorded_at": "2016-04-30T01:01:01.111Z"
  	}],
  	"stacking": "percentage",
  	"definition": "The adoption of each member service by myGov users.",
  	"updated_at": "2016-08-22T00:17:06.674Z",
  	"displayRoundedData": true
  }


  describe 'up' do

    context 'decimal' do
      let(:latest_value)    { 100 }
      let(:previous_value)  { 50 }

      context '$' do
        let(:unit)    { '$' }
        its(:summary) { is_expected.to eq 'Up by $50.00 since Jan 2020' }
      end

      context 's' do
        let(:unit)    { '%' }
        its(:summary) { is_expected.to eq 'Up by 50.00% since Jan 2020' }
      end

      context 'i' do
        let(:unit)    { 'i' }
        its(:summary) { is_expected.to eq 'Up by 50 since Jan 2020' }
      end
    end

    context 'decimal' do
      let(:latest_value)    { 100 }
      let(:previous_value)  { 50.50 }

      context '$' do
        let(:unit)    { '$' }
        its(:summary) { is_expected.to eq 'Up by $49.50 since Jan 2020' }
      end

      context 's' do
        let(:unit)    { '%' }
        its(:summary) { is_expected.to eq 'Up by 49.50% since Jan 2020' }
      end
    end
  end

  describe 'down' do

    context 'decimal' do
      let(:latest_value)    { 50 }
      let(:previous_value)  { 100 }

      context '$' do
        let(:unit)    { '$' }
        its(:summary) { is_expected.to eq 'Down by $50.00 since Jan 2020' }
      end

      context 's' do
        let(:unit)    { '%' }
        its(:summary) { is_expected.to eq 'Down by 50.00% since Jan 2020' }
      end

      context 'i' do
        let(:unit)    { 'i' }
        its(:summary) { is_expected.to eq 'Down by 50 since Jan 2020' }
      end
    end

    context 'decimal' do
      let(:latest_value)    { 50.50 }
      let(:previous_value)  { 100 }

      context '$' do
        let(:unit)    { '$' }
        its(:summary) { is_expected.to eq 'Down by $49.50 since Jan 2020' }
      end

      context 's' do
        let(:unit)    { '%' }
        its(:summary) { is_expected.to eq 'Down by 49.50% since Jan 2020' }
      end
    end
  end

  describe 'unchanged' do
    let(:latest_value)    { 100 }
    let(:previous_value)  { 100 }

    context '$' do
      let(:unit)    { '$' }
      its(:summary) { is_expected.to eq 'Unchanged since Jan 2020' }
    end

    context 's' do
      let(:unit)    { '%' }
      its(:summary) { is_expected.to eq 'Unchanged since Jan 2020' }
    end

    context 'i' do
      let(:unit)    { 'i' }
      its(:summary) { is_expected.to eq 'Unchanged since Jan 2020' }
    end
  end

  describe 'size extra-small to style' do
    let(:widget) { FactoryGirl.create(:widget, :size => 'extra-small') }
    subject { widget.decorate }
    its(:size_to_style) { is_expected.to eq 'aus-width-one-fourth' }
  end

  describe 'size small to style' do
    let(:widget) { FactoryGirl.create(:widget, :size => 'small') }
    subject { widget.decorate }
    its(:size_to_style) { is_expected.to eq 'aus-width-one-third' }
  end

end
