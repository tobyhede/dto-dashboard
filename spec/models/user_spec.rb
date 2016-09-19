require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many :tokens }
  it { is_expected.to have_and_belong_to_many :dashboards }

  describe 'tokens' do
    let(:active)   { Token.create! }
    let(:expired)  { FactoryGirl.create(:token_expired) }

    subject(:user) { FactoryGirl.create(:user, :tokens => [expired, active]) }

    describe 'expiration' do
      its(:token) { should eq active }
      its(:token) { should_not eq expired }
    end

    describe '#authenticate!' do
      context 'active token' do
        let(:authenticated) { User.authenticate!(active) }
        it { expect(user).to eq authenticated }
      end

      context 'expired token' do
        it { expect{ User.authenticate!(expired) }.to raise_error(ActiveRecord::RecordNotFound) }
      end

      context 'invalid token' do
        it { expect{ User.authenticate!('blahvtha') }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end


  describe 'dashboards and datasets' do
    subject(:dashboard) { FactoryGirl.create(:dashboard_with_widgets) }
    it { expect( dashboard.datasets ).to have_at_least(1).dataset }
  end
end
