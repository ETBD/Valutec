require 'httparty'

module Valutec
  class Card
    include HTTParty

    base_uri 'https://ws.valutec.net/Valutec.asmx'

    attr_accessor :client_key, :terminal_id

    def initialize(config_vars={})
      @client_key = get_client_key(config_vars)
      @terminal_id = get_terminal_id(config_vars)
    end

    def card_balance
      response = make_api_call('/Transaction_CardBalance')
    end

    def add_value
      response = make_api_call('/Transaction_AddValue')
    end

    def activate_card
      response = make_api_call('/Transaction_ActivateCard')
    end

    def cash_out
      response = make_api_call('/Transaction_CashOut')
    end

    def create_card
      response = make_api_call('/Transaction_CreateCard')
    end

    def deactivate_card
      response = make_api_call('/Transaction_DeactivateCard')
    end

    def host_totals
      response = make_api_call('/Transaction_HostTotals')
    end

    def replace_card
      response = make_api_call('/Transaction_ReplaceCard')
    end

    def sale
      response = make_api_call('/Transaction_Sale')
    end

    def void
      response = make_api_call('/Transaction_Void')
    end

    private

    def make_api_call(method,params={})
      params.merge!({"ClientKey" => client_key, "TerminalID" => terminal_id})
      self.class.get(method,params)
    end

    def get_client_key(config_vars)
      if config_vars[:client_key]
        config_vars[:client_key]
      elsif ENV['VALUTEC_CLIENT_KEY']
        ENV['VALUTEC_CLIENT_KEY']
      else
        raise "ENV['VALUTEC_CLIENT_KEY'] not specified, nor is it included in class initialization"
      end
    end

    def get_terminal_id(config_vars)
      if config_vars[:terminal_id]
        config_vars[:terminal_id]
      elsif ENV['VALUTEC_TERMINAL_ID']
        ENV['VALUTEC_TERMINAL_ID']
      else
        raise "ENV['VALUTEC_TERMINAL_ID'] not specified, nor is it included in class initialization"
      end

    end
  end
end
