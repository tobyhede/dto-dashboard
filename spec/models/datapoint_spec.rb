require 'rails_helper'

RSpec.describe Datapoint, type: :model do

  it { is_expected.to belong_to :dataset }

  it { is_expected.to validate_presence_of :ts }
  it { is_expected.to validate_numericality_of :value }

  let(:dataset) { Fabricate(:dataset) }

  describe '#label' do
    subject     { Fabricate(:datapoint, :ts => Date.parse('2016-01-01'), :dataset => dataset) }
    its(:label) { is_expected.to eq '2016-01' }
  end

end
