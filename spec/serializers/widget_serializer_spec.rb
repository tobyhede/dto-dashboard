require 'rails_helper'

RSpec.describe WidgetSerializer, type: :serializer do

  let(:widget) { FactoryGirl.create(:widget_with_datasets) }

  subject(:data) { WidgetSerializer.new(widget).to_json }

  it { should include('id') }
  it { should include('name') }
  # it { should include('latest') }
  # it { should include('suffix') }
  # it { should include('datasets') }
  # it { should include('summary') }

  it {
    puts data
  }

end
