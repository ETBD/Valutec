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
      Response.new(response,self,response["TransactionResponse"]["Balance"].to_f)
    end

    def add_value(value)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_AddValue',request_params)
      Response.new(response,self,response["TransactionResponse"]["Authorized"] == "true")
    end

    def activate_card(value)
      raise "Not Implemented"
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      }
      response = api.call('/Transaction_ActivateCard',request_params)
      # Response.new(response,self,response["TransactionResponse"]["Authorized"] == "true")
    end

    def cash_out
      raise "Not Implemented"
      # this may need :amount defined as well
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_CashOut',request_params)
    end

    def create_card(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardProgram" => "0xE8A72FDE1E31FF45ADE44460DB4B403B",
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_CreateCard',request_params)
      if response["TransactionResponse"]["Authorized"] == "true"
        new_card = Card.new(card_number: response["TransactionResponse"]["CardNumber"])
        Response.new(response,new_card,true)
      else
        Response.new(response,nil,false)
      end
    end

    def deactivate_card
      raise "Not Implemented"
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_DeactivateCard',request_params)
    end

    def sale(amount)
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => amount.to_f
      }
      response = api.call('/Transaction_Sale',request_params)
      Response.new(response,self,!response["TransactionResponse"]["ErrorMsg"])
    end

    def self.host_totals
      raise "Valutec::Card.host_totals not implemented"
      response = api.call('/Transaction_HostTotals',request_params)
    end

    def replace_card(new_number)
      raise "Valutec::Card#replace_card not implemented"
      new_number = new_number.to_f
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_ReplaceCard',request_params)
    end

    def restaurant_sale
      raise "Valutec::Card#resturant_sale not implemented"
    end

    def void
      raise "Valutec::Card#void not implemented"
      request_params = {
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      }
      response = api.call('/Transaction_Void',request_params)
    end

    private

    def normalize_card_number(card_number)
      card_number.to_s.gsub(/\W/,'').to_i
    end

  end
end
