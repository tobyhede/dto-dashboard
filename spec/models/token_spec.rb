require 'rails_helper'

RSpec.describe Token, type: :model do

  it { is_expected.to have_and_belong_to_many :datasets }

  describe 'generates a token' do
    subject(:token) { Token.create! }

    its(:token) { should be_present }
    its(:to_s) { should eq token.token }
  end

  context 'token with many datasets' do
    let(:token)     { FactoryGirl.create(:token) }
    let(:datasets)  { 3.times.collect { FactoryGirl.create(:dataset, tokens: [token]) } }

    describe '#authenticate' do
      subject(:authed_token) { Token.authenticate(token) }
      it 'finds the correct dataset' do
        expect(datasets).to eq authed_token.datasets.all
      end
    end
  end



end
