# frozen_string_literal: true

require "http"
require "json"

module Sixteen
  class Checker
    SIXTEEN_SHOP_ENDPOINT = "http://16shop.online/api/setting/get_setting.php"

    def check_setting(domain)
      res = HTTP.post(SIXTEEN_SHOP_ENDPOINT, form: { domain: domain })
      return nil if res.code != 200

      json = JSON.parse(res.body.to_s)
      json.dig("email_result") ? json : nil
    end

    def check_config(domain)
      %w(http https).each do |scheme|
        url = "#{scheme}://#{domain}/.config"
        res = HTTP.get(url)
        next if res.code != 200

        body = res.body.to_s
        return body if body.include?("lock_platform") && body.include?("site_password")
      rescue StandardError => _
        next
      end
      nil
    end

    def check(domain)
      setting = check_setting(domain)
      return setting if setting

      check_config(domain)
    end

    def self.check(domain)
      new.check(domain)
    end
  end
end
