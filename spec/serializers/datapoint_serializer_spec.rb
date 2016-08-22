require 'rails_helper'

RSpec.describe DatapointSerializer, type: :serializer do

  let(:datapoint) { FactoryGirl.create(:datapoint, :dataset_id => 1) }

  subject(:data) { DatapointSerializer.new(datapoint).to_hash }

  it { should include(:label) }
  it { should include(:value) }

end
