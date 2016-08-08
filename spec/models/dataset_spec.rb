require 'rails_helper'

RSpec.describe Dataset, type: :model do
  
  it { is_expected.to belong_to :organisation }
  it { is_expected.to have_many :widgets }
  it { is_expected.to have_many :datapoints }
  it { is_expected.to have_many :dataset_widgets }

  it { is_expected.to validate_presence_of :name }

end
