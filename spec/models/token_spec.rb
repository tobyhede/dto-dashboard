require 'rails_helper'

RSpec.describe Token, type: :model do

  # it { is_expected.to have_one :organisation }
  it { is_expected.to have_and_belong_to_many :datasets }

  describe 'generates a token' do
    subject(:token) { Token.create! }

    its(:token) { should be_present }
    its(:to_s) { should eq token.token }
  end


end
