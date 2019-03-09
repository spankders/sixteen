# frozen_string_literal: true

require "http"
require "json"
require "uri"

module Sixteen
  class Source
    KEYWORDS = %w{tune alert ap cloud forgot id official sigin ver}.freeze
    URLSCAN_ENDPOINT = "https://urlscan.io/api/v1/search/?q=PhishTank%20OR%20OpenPhish%20OR%20CertStream-Suspicious&size=2000"
    AYASHIGE_ENDPOINT = "http://ayashige.herokuapp.com/feed"
    OPENPHISH_ENDPOINT = "https://openphish.com/feed.txt"

    def checking_regexp
      @checking_regexp ||= Regexp.new(KEYWORDS.join("|"))
    end

    def urlscan_domains
      res = HTTP.get(URLSCAN_ENDPOINT)
      return [] if res.status != 200

      json = JSON.parse(res.body.to_s)
      results = json["results"]
      results.map { |result| result.dig("page", "domain") }
    end

    def ayashige_domains
      res = HTTP.get(AYASHIGE_ENDPOINT)
      return [] if res.status != 200

      json = JSON.parse(res.body.to_s)
      json.map { |item| item["domain"] }
    end

    def openphish_domains
      res = HTTP.get(OPENPHISH_ENDPOINT)
      return [] if res.status != 200

      lines = res.body.to_s.lines
      lines.map(&:chomp).map do |line|
        uri = URI(line)
        uri.host
      rescue StandardError => _
        nil
      end.compact
    end

    def domains
      (urlscan_domains + ayashige_domains + openphish_domains).uniq.compact
    end

    def phishy_domains
      domains.select do |domain|
        domain.match? checking_regexp
      end
    end

    def self.phishy_domains
      new.phishy_domains
    end
  end
end
