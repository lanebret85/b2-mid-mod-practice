require "rails_helper"

RSpec.describe Department, type: :model do
  describe "relationships" do
    it { should have_many :employees }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :floor }
  end
end