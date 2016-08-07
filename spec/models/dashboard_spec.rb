require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  let(:organisation) { Organisation.create!(:name => 'Dept of Vtha', :url => 'vtha.gov.au')  }

  it 'is not a good test' do

    dashboard = Dashboard.create!(:name => 'Dashboard', :organisation => organisation)

    widget = Widget.create!(
      :dashboard    => dashboard,
      :name         => 'numbers-bar',
      :description  => 'numbers',
      :size         => 'small',
      :type         => 'line',
      :units        => 'n',
      :row          => 0,
      :pos          => 0)

    dataset = widget.datasets.create!(
      :name => 'numbers',
      :organisation => organisation)

    datapoint = dataset.datapoints.create!(:ts => Time.now, :value => 99)

    # puts widget.inspect
    # puts dataset.inspect
    # puts dashboard.widgets.inspect
  end
end
