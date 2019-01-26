# frozen_string_literal: true

RSpec.describe Sixteen::Checker, :vcr do
  subject { Sixteen::Checker.new }

  describe "#check_setting" do
    it "should return a hash" do
      results = subject.check_setting("m-appleidsloscked.com")
      expect(results).to be_a(Hash)
    end
  end

  describe "#check_config" do
    it "should return a string" do
      results = subject.check_config("appleidaccountverify.com")
      expect(results).to be_a(String)
    end
  end

  describe "#check_admin" do
    it "should return a string" do
      results = subject.check_admin("apple-signin.servehttp.com")
      expect(results).to be_a(String)
      expect(results).to include("admin panel")
    end
  end

  describe ".check" do
    context "when given an invalid domain" do
      it "should return a nil" do
        results = Sixteen::Checker.check("example.com")
        expect(results).to eq(nil)
      end
    end
  end
end
