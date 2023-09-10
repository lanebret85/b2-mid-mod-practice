require "rails_helper"

RSpec.describe Employee, type: :model do
  describe "relationships" do
    it { should belong_to :department }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :level }
  end
end