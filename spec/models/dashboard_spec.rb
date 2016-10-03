require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  it { is_expected.to belong_to :organisation }

  it { is_expected.to have_many :widgets }

  it { is_expected.to have_and_belong_to_many :users }

  it { is_expected.to validate_presence_of :name }
    
  subject!(:dashboard)    { FactoryGirl.create(:dashboard) }

  its(:to_param) { is_expected.to include(dashboard.name.parameterize) }

  describe 'url' do
    it { should_not allow_value('<blah').for(:url) }
    it { should allow_value('blah.com').for(:url) }

    subject(:dashboard) { FactoryGirl.build(:dashboard, :url => '<BLAH>') }

    it 'validation' do
      expect(dashboard).to be_invalid
      expect(dashboard.errors[:url]).to be_present
    end
  end

  context 'unpublished' do
    subject { Dashboard.published.all }
    it      { is_expected.to be_empty }
  end

  context 'published' do
    let!(:dashboard) { FactoryGirl.create(:dashboard_published) }
    subject { Dashboard.published.all }
    it      { is_expected.to have(1).dashboard }
  end

  describe 'kpi widgets' do
    let!(:widget) { FactoryGirl.create(:widget, :name => 'User Satisfaction', :dashboard => dashboard) }
    subject { dashboard.widgets.kpis }
    it { is_expected.to have(1).widget }
  end

  describe 'last_updated' do
    before do
      FactoryGirl.create(:widget, :dashboard => dashboard, :last_updated_at => '2020-01-01')
      FactoryGirl.create(:widget, :dashboard => dashboard)
    end

    it { expect(dashboard.last_updated_at).to eq Date.parse('2020-01-01') }
  end

  describe 'other widgets' do
    let!(:widget) { FactoryGirl.create(:widget, :dashboard => dashboard) }
    subject { dashboard.widgets.other }
    it { is_expected.to have(1).widget }
  end

  describe '#rows' do
    let!(:widget_1_0) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 1, :pos => 0) }
    let!(:widget_0_0) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 0, :pos => 0) }
    let!(:widget_1_1) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 1, :pos => 1) }
    let!(:widget_0_1) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 0, :pos => 1) }
    let!(:widget_2_0) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 2, :pos => 0) }

    # subject { dashboard.rows }
    it { expect(dashboard.rows).to eq [[widget_0_0, widget_0_1], [widget_1_0, widget_1_1], [widget_2_0]] }
    it { expect(dashboard.first_row).to eq [widget_0_0, widget_0_1] }
    it { expect(dashboard.remaining_rows).to eq [[widget_1_0, widget_1_1], [widget_2_0]] }
  end

  describe 'datasets' do
    subject(:dashboard) { FactoryGirl.create(:dashboard_with_widgets) }
    it { expect( dashboard.datasets ).to have_at_least(1).dataset }
  end
end
