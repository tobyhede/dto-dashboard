require 'rails_helper'

RSpec.describe WidgetDecorator, type: :decorator do

  let(:latest_value)    { 99 }
  let(:latest_ts)       { Date.parse('2020-02-01') }

  let(:previous_value)  { 99 }
  let(:previous_ts)     { Date.parse('2020-01-01') }

  let(:unit)            { 's' }

  let(:widget)      { FactoryGirl.create(:widget) }
  let(:dataset)     { FactoryGirl.create(:dataset, :units => unit) }

  let!(:latest)     { FactoryGirl.create(:datapoint, :dataset => dataset, :ts => latest_ts, :value => latest_value) }
  let!(:previous)   { FactoryGirl.create(:datapoint, :dataset => dataset, :ts => previous_ts, :value => previous_value) }

  before {
    widget.datasets << dataset
    widget.save!
  }

  subject { widget.decorate }

  its(:summary) { is_expected.to eq '' }

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
end
