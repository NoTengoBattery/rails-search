require "rails_helper"
require "shared_rutines"

RSpec.describe Search, type: :model do
  context "with validations" do
    subject { FactoryBot.build(:search) }

    it { is_expected.to validate_presence_of(:engine) }
    it { is_expected.to validate_presence_of(:search) }
    it { is_expected.to allow_values(Search::ENGINES).for(:engine) }
  end
end
