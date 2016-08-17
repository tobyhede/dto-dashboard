require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  it { is_expected.to belong_to :organisation }
  it { is_expected.to have_many :widgets }

  it { is_expected.to validate_presence_of :name }

  let(:published_at)  { nil }
  let!(:dashboard)    { FactoryGirl.create(:dashboard, :published_at => published_at) }

  context 'unpublished' do
    subject { Dashboard.published.all }
    it      { is_expected.to be_empty }
  end

  context 'published' do
    let(:published_at) { 4.days.ago }
    subject { Dashboard.published.all }
    it      { is_expected.to have(1).dashboard }
  end

  describe 'kpi widgets' do
    let!(:widget) { FactoryGirl.create(:widget, :name => 'User Satisfaction', :dashboard => dashboard) }
    subject { dashboard.widgets.kpis }
    it { is_expected.to have(1).widget }
  end

  describe 'other widgets' do
    let!(:widget) { FactoryGirl.create(:widget, :dashboard => dashboard) }
    subject { dashboard.widgets.other }
    it { is_expected.to have(1).widget }
  end


  describe 'rows' do
    let!(:widget_1_0) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 1, :pos => 0) }
    let!(:widget_0_0) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 0, :pos => 0) }
    let!(:widget_1_1) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 1, :pos => 1) }
    let!(:widget_0_1) { FactoryGirl.create(:widget, :dashboard => dashboard, :row => 0, :pos => 1) }

    subject { dashboard.rows }
    # it {
    #   puts dashboard.rows
    # }
    it { is_expected.to eq [[widget_0_0, widget_0_1], [widget_1_0, widget_1_1]] }

  end
end
