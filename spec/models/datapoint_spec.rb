require 'rails_helper'

RSpec.describe Datapoint, type: :model do

  it { is_expected.to belong_to :dataset }

  it { is_expected.to validate_presence_of :ts }
  it { is_expected.to validate_numericality_of :value }

end
