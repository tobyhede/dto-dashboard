require 'rails_helper'

RSpec.describe Widget, type: :model do

  let(:size)   { %w(extra-small small medium large extra-large) }
  let(:type)   { %w(bar fact full kpi-sparkline line pie sparkline) }
  let(:units)  { %w(% $ n) }

  it { is_expected.to belong_to :dashboard }
  it { is_expected.to have_many :datasets }
  it { is_expected.to have_many :dataset_widgets }

  it { is_expected.to validate_presence_of :name }

  it { should validate_presence_of(:size) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:units) }

  it { is_expected.to validate_inclusion_of(:size).in_array(size) }
  it { is_expected.to validate_inclusion_of(:type).in_array(type) }
  it { is_expected.to validate_inclusion_of(:units).in_array(units) }

end
