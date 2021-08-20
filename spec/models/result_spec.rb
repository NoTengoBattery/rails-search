require "rails_helper"
require "shared_rutines"

RSpec.describe Result, type: :model do
  context "with validations" do
    subject { FactoryBot.build(:result) }

    it { is_expected.to validate_presence_of(:extract) }
    it { is_expected.to validate_presence_of(:headline) }
    it { is_expected.to validate_presence_of(:mappings) }
    it { is_expected.to validate_presence_of(:provider) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
