require 'rails_helper'

RSpec.describe DatasetSerializer, type: :serializer do

  let(:dataset) { FactoryGirl.create(:dataset_with_datapoints) }

  let(:serializer)  { DatasetSerializer.new(dataset, :include => '**') }

  subject(:data)    { JSON.parse(serializer.to_json) }

  it { should include('id') }
  it { should include('name') }
  it { should include('units') }
  it { should include('datapoints') }

  # it {
  #   puts serializer.to_json
  # }  

  describe 'data' do
    subject { data['datapoints'].first }

    it { should include('label') }
    it { should include('value') }
  end

end
