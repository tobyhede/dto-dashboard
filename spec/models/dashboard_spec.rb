require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  it { is_expected.to belong_to :organisation }
  it { is_expected.to have_many :widgets }

  it { is_expected.to validate_presence_of :name }

  let(:published_at)  { nil }
  let!(:dashboard)    { Fabricate(:dashboard, :published_at => published_at) }

  context 'unpublished' do
    subject { Dashboard.published.all }
    it      { is_expected.to be_empty }
  end

  context 'published' do
    let(:published_at) { 4.days.ago }
    subject { Dashboard.published.all }
    it      { is_expected.to have(1).dashboard }
  end

end
