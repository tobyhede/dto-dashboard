require 'rails_helper'

RSpec.describe DatapointSerializer, type: :serializer do

  let(:dataset) { FactoryGirl.create(:dataset) }
  let(:datapoint) { FactoryGirl.create(:datapoint, :dataset => dataset) }

  let(:serializer)  { DatapointSerializer.new(datapoint).to_hash }

  subject(:data)    { JSON.parse(serializer.to_json) }

  it { should include('label') }
  it { should include('value') }

  it { expect(data['value']).to eq datapoint.value.to_s }
end
