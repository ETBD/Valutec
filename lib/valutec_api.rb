require "valutec_api/version"
require "valutec_api/card"
require "valutec_api/report"
require 'httparty'

module ValutecApi
  include HTTParty
  base_uri 'https://ws.valutec.net/Valutec.asmx'
end
