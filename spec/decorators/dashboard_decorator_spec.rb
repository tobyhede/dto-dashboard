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

  let(:dashboard) { FactoryGirl.create(:dashboard, :notes => '# Heading') }
  let(:decorator) { DashboardDecorator.new(dashboard) }

  describe 'convert notes to html' do
    subject { decorator.notes_to_html }

    it { is_expected.to eq "<h1>Heading</h1>\n" }

  end

  describe "filter dashboard name test" do
    title = "Australian Citizenship Appointment Booking Service Dashboard"
    subject { decorator.filter_dashboard_name title }

    it { is_expected.to eq "Australian Citizenship Appointment Booking Service" }
  end

  describe "filter dashboard name test 2" do
    title = "Australian citizenship appointment booking service dashboard"
    subject { decorator.filter_dashboard_name title }

    it { is_expected.to eq "Australian citizenship appointment booking service"}

  end

  describe "filter dashboard name test 3" do
    title = "Hobby or Business Tool"
    subject { decorator.filter_dashboard_name title }

    it { is_expected.to eq "Hobby or Business Tool"}

  end


end
