# frozen_string_literal: true

require "http"
require "json"

module Sixteen
  class Website
    API_ENDPOINTS = ["http://16shop.online", "http://server2.16shop.online"].freeze

    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def setting
      @setting ||= [].tap do |out|
        API_ENDPOINTS.each do |endpoint|
          url = "#{endpoint}/api/setting/get_setting.php"
          res = HTTP.post(url, form: { domain: domain })
          next if res.code != 200

          json = JSON.parse(res.body.to_s)
          out << JSON.pretty_generate(json) if json.dig("email_result")
        end
      end.first
    end

    def setting?
      setting != nil
    end

    def config
      @config ||= [].tap do |out|
        base_urls.each do |base_url|
          url = "#{base_url}/.config"
          body = get_body(url)

          out << body.strip if body&.include?("lock_platform") && body&.include?("site_password")
        end
      end.first
    end

    def config?
      config != nil
    end

    def admin_panel
      @admin_panel ||= [].tap do |out|
        base_urls.each do |base_url|
          url = "#{base_url}/admin"
          body = get_body(url)
          out << "16shop admin panel: #{url}." if body&.include?("<title>16Shop - Admin Panel</title>")
        end
      end.first
    end

    def admin_panel?
      admin_panel != nil
    end

    def expired_key
      @expired_key ||= [].tap do |out|
        base_urls.each do |base_url|
          body = get_body(base_url)
          out << "16shop with an expired key: #{url}." if body&.include?("BUY NOW") && body&.include?("KEY EXPIRED!")
        end
      end.first
    end

    def expired_key?
      expired_key != nil
    end

    def base_urls
      %w(http https).map { |scheme| "#{scheme}://#{domain}" }
    end

    def sixteen_shop?
      [setting?, config?, admin_panel?].any?
    end

    def to_attachments
      [].tap do |out|
        out << { text: setting } if setting?
        out << { text: config } if config?
        out << { text: admin_panel } if admin_panel?
        out << { text: expired_key } if expired_key?
      end
    end

    private

    def get_body(url)
      res = HTTP.follow.timeout(3).get(url)
      return nil if res.code != 200

      res.body.to_s
    rescue HTTP::Error, OpenSSL::SSL::SSLError => _
      nil
    end
  end
end
