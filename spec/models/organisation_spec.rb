require 'rails_helper'

RSpec.describe Organisation, type: :model do

  it { is_expected.to have_many :dashboards }
  it { is_expected.to have_many :datasets }
  it { is_expected.to have_and_belong_to_many :tokens }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :url }


  describe 'authentication' do
    subject(:organisation) { FactoryGirl.create(:organisation_with_token) }

    its(:token) { should be_present }
    its(:token) { should eq organisation.tokens.first }


    describe '#authenicate' do
      let(:token) { organisation.token }

      it 'finds the correct organisation' do
        expect(organisation).to eq Organisation.authenticate(token)
        expect(organisation).to_not eq Organisation.authenticate('blahvtha')
      end

    end
  end
end
