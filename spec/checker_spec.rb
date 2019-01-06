# frozen_string_literal: true

RSpec.describe Sixteen::Checker, :vcr do
  subject { Sixteen::Checker }

  describe "#check" do
    context "when given a valid domain" do
      it "should return Hash with values" do
        results = subject.check("movel-appleid.com")
        expect(results).to be_an(Hash)
      end
    end
    context "when given an invalid domain" do
      it "should return Hash with nil values" do
        results = subject.check("movelappleid.com")
        expect(results).to be_an(Hash)
      end
    end
  end
end
