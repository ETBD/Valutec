require 'httparty'
require 'singleton'

module Valutec
  class Api
    include HTTParty
    include Singleton

    base_uri 'https://ws.valutec.net/Valutec.asmx'

    attr_accessor :client_key, :terminal_id, :server_id

    Response = Struct.new(:response, :error)

    def initialize(config_vars={})
      @client_key = ENV['VALUTEC_CLIENT_KEY'] || raise("ENV['VALUTEC_CLIENT_KEY'] not specified")
      @terminal_id = ENV['VALUTEC_TERMINAL_ID'] || raise("ENV['VALUTEC_TERMINAL_ID'] not specified, nor is it included in class initialization")
      @server_id = ENV['VALUTEC_SERVER_ID'] || raise("ENV['VALUTEC_SERVER_ID'] not specified, nor is it included in class initialization")
    end

    def call(method,params={})
      params.merge!(
        {"ClientKey" => client_key,
          "TerminalID" => terminal_id,
          "ServerID" => server_id,
          "Identifier" => identifier}
          )
      response = self.class.get(method,{query: params})
      # TODO: Use or lose :error variable in Response
      Response.new(response, "No errors detected.")
    end

    private

    def identifier
      # I'm not convinced identifier is used for anything, but Valutec
      # complains when this param is missing. Generate random things to
      # shove into this field unless otherwise specified.
      ENV.fetch('VALUTEC_IDENTIFIER', SecureRandom.hex(5))
    end
  end
end
