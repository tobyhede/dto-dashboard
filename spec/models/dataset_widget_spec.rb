require 'rails_helper'

RSpec.describe DatasetWidget, type: :model do
  it { is_expected.to belong_to :widget }
  it { is_expected.to belong_to :dataset }
end
