# frozen_string_literal: true

require "json"

module Sixteen
  class Monitor
    def self.perform
      domains = Sixteen::Source.phishy_domains
      websites = domains.map { |domain| Website.new(domain) }

      websites.each do |website|
        next unless website.sixteen_shop?

        Notifier.notify(website.domain, website.setting) if website.setting?
        Notifier.notify(website.domain, website.config) if website.config?
        Notifier.notify(website.domain, website.admin_panel) if website.admin_panel?
      end
    end
  end
end
