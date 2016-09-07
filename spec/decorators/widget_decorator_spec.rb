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

  describe 'size to style' do
    let(:attrs) { {} }
    let(:widget) { FactoryGirl.create(:widget, attrs) }
    subject { widget.decorate }

    context 'extra-small' do
      let(:attrs) { {:size => 'extra-small'} }
      its(:size_to_style) { is_expected.to eq 'aus-width-one-fourth' }
    end

    context 'small' do
      let(:attrs) { {:size => 'small'} }
      its(:size_to_style) { is_expected.to eq 'aus-width-one-third' }
    end

    context 'full' do
      let(:attrs) { {:size => 'extra-large'} }
      its(:size_to_style) { is_expected.to eq 'aus-width-one-whole' }
    end


  end

end
