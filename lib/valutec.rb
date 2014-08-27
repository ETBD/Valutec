require "valutec/version"
require "valutec/card"
require 'httparty'

module Valutec
  include HTTParty
  base_uri 'https://ws.valutec.net/Valutec.asmx'

  class Report
    def by_card
    end

    def by_LID
    end

    def by_MID
    end

    def by_TID
    end
  end
end
