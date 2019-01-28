# frozen_string_literal: true

RSpec.describe Sixteen::Website, :vcr do
  subject { Sixteen::Website.new("www.appleservices-access-customers.com.renewsingin.info") }

  describe "#sixteen_shop?" do
    it "should return true" do
      result = subject.sixteen_shop?
      expect(result).to eq(true)
    end
  end

  describe "#setting?" do
    it "should return false" do
      result = subject.setting?
      expect(result).to eq(false)
    end
  end

  describe "#config?" do
    it "should return true" do
      result = subject.config?
      expect(result).to eq(true)
    end
  end

  describe "#admin_panel?" do
    it "should return true" do
      result = subject.admin_panel?
      expect(result).to eq(true)
    end
  end
end
