require 'rails_helper'

RSpec.describe DashboardDecorator, type: :decorator do

  context 'dashboard' do
    let(:dashboard) { FactoryGirl.create(:dashboard) }
    subject {dashboard.decorate}
    it { is_expected.to_not be_show_hero }
    it { is_expected.to_not be_show_kpis }
  end

  context 'dashboard with widgets' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets) }
    subject {dashboard.decorate}

    it { is_expected.to be_show_hero }
    it { is_expected.to be_show_kpis }
  end

  context 'hide hero' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, :display_hero => false) }
    subject {dashboard.decorate}

    it { is_expected.to_not be_show_hero }
    it { is_expected.to be_show_kpis }
  end

  context 'hide kpis' do
    let(:dashboard) { FactoryGirl.create(:dashboard_with_widgets, :display_hero => true, :display_kpis => false) }
    subject {dashboard.decorate}

    it { is_expected.to_not be_show_hero }
    it { is_expected.to_not be_show_kpis }
  end


  describe 'convert notes to html' do
    let(:dashboard) { FactoryGirl.create(:dashboard, :notes => '# Heading') }
    let(:decorator) { DashboardDecorator.new(dashboard) }

    subject { decorator.notes_to_html }

    it { is_expected.to eq "<h1>Heading</h1>\n" }

  end

  describe 'verify "dashboard" strips from title' do
    let(:dashboard) { FactoryGirl.create(:dashboard, :name => "Australian Citizenship Appointment Booking Service Dashboard") }
    let(:decorator) { DashboardDecorator.new(dashboard) }

    subject { decorator.title }

    it { is_expected.to eq "Australian Citizenship Appointment Booking Service" }
  end

end
