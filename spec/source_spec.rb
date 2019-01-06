# frozen_string_literal: true

RSpec.describe Sixteen::Source, :vcr do
  subject { Sixteen::Source }

  describe "#phishy_domains" do
    it "should return an Array" do
      results = subject.phishy_domains
      expect(results).to be_an(Array)
    end
  end
end
