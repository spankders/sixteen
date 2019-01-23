# frozen_string_literal: true

RSpec.describe Sixteen::Checker, :vcr do
  subject { Sixteen::Checker }

  describe "#check" do
    context "when given a valid domain" do
      it "should return Hash with values" do
        results = subject.check("aple.supportaccounts.websrcauthsummary.com")
        expect(results).to be_a(Hash)
      end
    end
    context "when given an invalid domain" do
      it "should return Hash with nil values" do
        results = subject.check("apple-appleidd.ddns.net")
        expect(results).to eq(nil)
      end
    end
  end
end
