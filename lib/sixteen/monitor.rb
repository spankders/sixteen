# frozen_string_literal: true

require "json"

module Sixteen
  class Monitor
    def self.perform
      domains = Sixteen::Source.phishy_domains

      domains.each do |domain|
        result = Checker.check(domain)
        next unless result

        text = result.is_a?(Hash) ? JSON.pretty_generate(result) : result
        Notifier.notify(domain, text)
      end
    end
  end
end
