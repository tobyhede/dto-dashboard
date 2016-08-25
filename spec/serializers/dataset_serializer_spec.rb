require 'rails_helper'

RSpec.describe DatasetSerializer, type: :serializer do

  let(:dataset) { FactoryGirl.create(:dataset_with_datapoints) }

  let(:serializer)  { DatasetSerializer.new(dataset, :include => '**') }

  subject(:data)    { JSON.parse(serializer.to_json) }

  it { should include('id') }
  it { should include('name') }
  it { should include('units') }
  it { should include('notes') }
  it { should include('datapoints') }

  describe 'id' do
    subject { data['id'] }
    it { is_expected.to_not eq dataset.id }
    it { is_expected.to eq dataset.name.parameterize }
  end

  describe 'datapoints' do
    subject { data['datapoints'].first }

    it { should include('label') }
    it { should include('value') }
  end

end
