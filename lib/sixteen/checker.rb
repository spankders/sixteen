# frozen_string_literal: true

require "http"
require "json"

module Sixteen
  class Checker
    SIXTEEN_SHOP_ENDPOINT = "http://16shop.online/api/setting/get_setting.php"

    def check(domain)
      res = HTTP.post(SIXTEEN_SHOP_ENDPOINT, form: { domain: domain })
      return {} if res.status != 200

      JSON.parse(res.body.to_s)
    end

    def self.check(domain)
      new.check(domain)
    end
  end
end
