# frozen_string_literal: true

require "json"

module Sixteen
  class Monitor
    def self.perform
      domains = Sixteen::Source.phishy_domains

      domains.each do |domain|
        result = Checker.check(domain)
        next unless result.dig("email_result")

        Notifier.notify(domain, JSON.pretty_generate(result))
      end
    end
  end
end
