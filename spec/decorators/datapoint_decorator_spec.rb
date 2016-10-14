require 'rails_helper'

RSpec.describe DatapointDecorator, type: :decorator do

  let(:datapoint)     { FactoryGirl.create(:datapoint) }

  subject(:decorator) { datapoint.decorate }

  it{ expect(decorator.value('#','*')).to include '#' }
  it{ expect(decorator.value('#','*')).to include '*' }
  it{ expect(decorator.value('#','*')).to include datapoint.value.to_s }

  context 'with no data' do
    let(:datapoint) { FactoryGirl.create(:datapoint, :value => nil) }
    it{ expect(decorator.value('#','*')).to include 'no data' }
  end
end
