# frozen_string_literal: true

require "http"
require "json"

module Sixteen
  class Checker
    SIXTEEN_SHOP_BASE_URLS = ["http://16shop.online", "http://server2.16shop.online"]

    def check_setting(domain)
      SIXTEEN_SHOP_BASE_URLS.each do |base_url|
        url = "#{base_url}/api/setting/get_setting.php"
        res = HTTP.post(url, form: { domain: domain })
        next if res.code != 200

        json = JSON.parse(res.body.to_s)
        return json if json.dig("email_result")
      end
      nil
    end

    def check_config(domain)
      base_urls(domain).each do |base_url|
        url = "#{base_url}/.config"
        body = get_body(url)

        return body if body&.include?("lock_platform") && body&.include?("site_password")
      end
      nil
    end

    def check_admin(domain)
      base_urls(domain).each do |base_url|
        url = "#{base_url}/admin"
        body = get_body(url)
        return "16shop admin panel: #{url} (configuration is not found)." if body&.include?("<title>16Shop - Admin Panel</title>")
      end
      nil
    end

    def base_urls(domain)
      %w(http https).map { |scheme| "#{scheme}://#{domain}" }
    end

    def check(domain)
      setting = check_setting(domain)
      return setting if setting

      config = check_config(domain)
      return config if config

      check_admin(domain)
    end

    def self.check(domain)
      new.check(domain)
    end

    def get_body(url)
      res = HTTP.follow.timeout(3).get(url)
      return nil if res.code != 200

      res.body.to_s
    rescue HTTP::Error, OpenSSL::SSL::SSLError => _
      nil
    end
  end
end
