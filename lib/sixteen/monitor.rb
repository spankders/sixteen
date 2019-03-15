# frozen_string_literal: true

require "json"
require "parallel"
require "uri"

module Sixteen
  class Monitor
    def self.check(domain)
      website = Website.new(domain)
      return unless website.sixteen_shop?

      Notifier.notify(website.domain, website.to_attachments)
    end

    def self.perform
      domains = Sixteen::Source.phishy_domains
      websites = domains.map { |domain| Website.new(domain) }

      Parallel.each(websites) do |website|
        next if Cache.cached?(website.domain)
        next unless website.sixteen_shop?

        Notifier.notify(website.domain, website.to_attachments)
        Cache.save(website.domain, true)
      end
    end
  end
end
