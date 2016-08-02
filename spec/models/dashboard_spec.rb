require 'rails_helper'

RSpec.describe Dashboard, type: :model do

  let(:agency) { 'Dept of Vtha' }

  it 'is not a good test' do

    dashboard = Dashboard.create!(:name => agency, :agency => agency)

    widget = Widget.create!(
      :name         => 'numbers-bar',
      :description  => 'numbers',
      :size         => 'small',
      :type         => 'line',
      :units        => 'n')

    dataset = widget.datasets.create!(
      :name => 'numbers',
      :agency => agency)

    datapoint = dataset.datapoints.create!(:ts => Time.now, :value => 99)

    puts widget.inspect
    puts dataset.inspect
    puts dashboard.widgets.inspect


  end
end
