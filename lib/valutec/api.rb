require 'httparty'
require 'singleton'

module Valutec
  class Api
    include HTTParty
    include Singleton

    base_uri 'https://ws.valutec.net/Valutec.asmx'

    attr_accessor :client_key, :terminal_id, :server_id, :identifier

    Response = Struct.new(:response, :error)

    def initialize(config_vars={})
      @client_key = ENV['VALUTEC_CLIENT_KEY'] || raise("ENV['VALUTEC_CLIENT_KEY'] not specified")
      @terminal_id = ENV['VALUTEC_TERMINAL_ID'] || raise("ENV['VALUTEC_TERMINAL_ID'] not specified, nor is it included in class initialization")
      @server_id = ENV['VALUTEC_SERVER_ID'] || raise("ENV['VALUTEC_SERVER_ID'] not specified, nor is it included in class initialization")
      @identifier = ENV.fetch('VALUTEC_IDENTIFIER', SecureRandom.hex(5))

    end

    def call(method,params={})
      params.merge!(
        {"ClientKey" => client_key,
          "TerminalID" => terminal_id,
          "ServerID" => server_id,
          "Identifier" => identifier}
          )
      response = self.class.get(method,{query: params})
      Response.new(response, "No errors detected.")
    end
  end
end
