# frozen_string_literal: true

RSpec.describe Sixteen::Website, :vcr do
  subject { Sixteen::Website.new("www-account-appleld-alert.com") }
  describe "#sixteen_shop?" do
    it "should return true" do
      result = subject.sixteen_shop?
      expect(result).to eq(true)
    end
  end

  describe "#setting?" do
    it "should return true" do
      result = subject.setting?
      expect(result).to eq(false)
    end
  end

  describe "#config?" do
    it "should return false" do
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

  describe "#expired_key?" do
    it "should return false" do
      result = subject.expired_key?
      expect(result).to eq(false)
    end
  end

  describe "#panel?" do
    it "should return false" do
      result = subject.panel?
      expect(result).to eq(false)
    end
  end

  describe "#kit?" do
    it "should return false" do
      result = subject.kit?
      expect(result).to eq(false)
    end
  end

  describe "#invoice?" do
    it "should return false" do
      result = subject.invoice?
      expect(result).to eq(false)
    end
  end

  describe "#to_attachments" do
    it "should return an array" do
      attachments = subject.to_attachments
      expect(attachments).to be_an(Array)
      expect(attachments.all? { |a| a.dig(:text) }).to eq(true)
    end
  end
end
