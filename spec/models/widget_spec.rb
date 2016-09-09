require 'rails_helper'

RSpec.describe Widget, type: :model do

  let(:size)   { %w(extra-small small medium large extra-large) }
  let(:type)   { %w(bar fact full kpi-sparkline line pie sparkline) }
  let(:units)  { %w(% $ n) }

  it { is_expected.to belong_to :dashboard }
  it { is_expected.to have_many :datasets }
  it { is_expected.to have_many :dataset_widgets }

  it { is_expected.to validate_presence_of :name }

  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:units) }

  it { is_expected.to validate_inclusion_of(:size).in_array(size) }
  it { is_expected.to validate_inclusion_of(:type).in_array(type) }
  it { is_expected.to validate_inclusion_of(:units).in_array(units) }

  context 'with no data' do
    subject(:widget) { FactoryGirl.create(:widget) }
    it { is_expected.to_not have_data }
  end

  describe 'options' do
    subject(:widget) { FactoryGirl.create(:widget, :options => {'stacking' => 'percentage', 'displayRoundedData' => true}) }

    its(:options) {
      is_expected.to include('stacking')
      is_expected.to include('displayRoundedData')
    }
    it { expect(widget.options['stacking']).to eq 'percentage' }
    it { expect(widget.options['displayRoundedData']).to eq true }

  end

  describe 'kpis' do
    before {
      Widget::KPIS.each{ |n| FactoryGirl.create(:widget, :name => n) }
    }
    subject { Widget.kpis }
    it { is_expected.to have(4).widgets }
  end

  describe 'hero' do
    before {
      FactoryGirl.create(:widget, :is_hero => true)
    }
    subject { Widget.hero }
    it { is_expected.to have(1).widget }
  end

  describe 'units' do
    subject(:widget) { FactoryGirl.create(:widget, :units => units) }

    context 'seconds' do
      let(:units) { 's' }
      its(:suffix) { is_expected.to eq 's' }
      its(:prefix) { is_expected.to eq '' }
    end

    context 'percentage' do
      let(:units) { '%' }
      its(:suffix) { is_expected.to eq '%' }
      its(:prefix) { is_expected.to eq '' }
    end

    context 'money' do
      let(:units) { '$' }
      its(:suffix) { is_expected.to eq '' }
      its(:prefix) { is_expected.to eq '$' }
    end
  end

end
