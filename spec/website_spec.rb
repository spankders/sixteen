# frozen_string_literal: true

RSpec.describe Sixteen::Website, :vcr do
  context "when dealing with a website which has an admin panel" do
    subject { Sixteen::Website.new("login.xn--appleeidwebpss-083mzzo336gyblc.verificationalert03.com") }
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
        expect(result).to eq(false)
      end
    end

    describe "#admin_panel?" do
      it "should return true" do
        result = subject.admin_panel?
        expect(result).to eq(true)
      end
    end
  end

  context "when dealing with a website which has a setting" do
    subject { Sixteen::Website.new("verify.myaccount.apple.id.webapps-servticket.ut1837.com") }

    describe "#sixteen_shop?" do
      it "should return true" do
        result = subject.sixteen_shop?
        expect(result).to eq(true)
      end
    end

    describe "#setting?" do
      it "should return false" do
        result = subject.setting?
        expect(result).to eq(true)
      end
    end

    describe "#config?" do
      it "should return true" do
        result = subject.config?
        expect(result).to eq(false)
      end
    end

    describe "#admin_panel?" do
      it "should return true" do
        result = subject.admin_panel?
        expect(result).to eq(true)
      end
    end
  end
end
