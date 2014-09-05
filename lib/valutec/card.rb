module Valutec
  class Card

    attr_reader :card_number, :api

    Response = Struct.new(:raw_response, :card, :result)

    def initialize(config_vars={})
      if config_vars.fetch(:card_number,false)
        @card_number = normalize_card_number(config_vars[:card_number])
      end

      @api = Valutec::Api.instance
    end

    def card_number=(card_num)
      @card_number = normalize_card_number(card_num)
    end

    def card_balance
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_CardBalance',request_params)
    end

    def add_value(value)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_AddValue',request_params)
    end

    def activate_card(value)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_ActivateCard',request_params)
    end

    def cash_out
      # this may need :amount defined as well
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_CashOut',request_params)
    end

    def self.create_card(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_CreateCard',request_params)
    end

    def deactivate_card
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_DeactivateCard',request_params)
    end

    def self.host_totals
      response = api.call('/Transaction_HostTotals',request_params)
    end

    def replace_card(new_number)
      new_number = new_number.to_f
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_ReplaceCard',request_params)
    end

    def sale(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_Sale',request_params)
    end

    def void
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_Void',request_params)
    end

    private

    def normalize_card_number(card_number)
      card_number.to_s.gsub(/\W/,'')
    end

  end
end
