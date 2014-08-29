module Valutec
  class Card

    attr_reader :card_number, :api

    def initialize(config_vars={})

      if config_vars.fetch(:card_number,false)
        @card_number = normalize_card_number(config_vars[:card_number].to_s)
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
      binding.pry
    end

    def add_value(value)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_AddValue')
    end

    def activate_card(value)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_ActivateCard')
    end

    def cash_out
      # this may need :amount defined as well
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_CashOut')
    end

    def self.create_card(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_CreateCard')
    end

    def deactivate_card
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_DeactivateCard')
    end

    def self.host_totals
      response = api.call('/Transaction_HostTotals')
    end

    def replace_card(new_number)
      new_number = new_number.to_f
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_ReplaceCard')
    end

    def sale(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_Sale')
    end

    def void
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_Void')
    end

    private

    def normalize_card_number(card_number)
      card_number.gsub(/\W/,'')
    end

  end
end