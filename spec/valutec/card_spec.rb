require 'spec_helper'

describe Valutec::Card do
  let (:valid_card) {Valutec::Card.new({card_number: '1234-1234-1234-1234-123'})}
  let (:invalid_card) {Valutec::Card.new({card_number: '6666-6666-6666-6666-123'})}

  it "raises if client_key and terminal_id are not specified" do
    expect{Valutec::Card.new({client_key: '1234',terminal_id: '4321'})}.to_not raise_error
    expect{Valutec::Card.new({client_key: '1234'})}.to raise_error
    expect{Valutec::Card.new({terminal_id: '4321'})}.to raise_error
    expect{Valutec::Card.new}.to raise_error

    ENV['VALUTEC_TERMINAL_ID'] = "derp"
    ENV['VALUTEC_CLIENT_KEY'] = "doop"
    ENV['VALUTEC_SERVER_ID'] = "ferp"

    expect{Valutec::Card.new({client_key: '1234',terminal_id: '4321'})}.to_not raise_error
    expect{Valutec::Card.new({client_key: '1234'})}.to_not raise_error
    expect{Valutec::Card.new({terminal_id: '4321'})}.to_not raise_error
    expect{Valutec::Card.new}.to_not raise_error
  end

  context '#card_balance' do
    it "#result returns card balance as a float if exists" do
      stub_request(:get, "https://ws.valutec.net/Valutec.asmx/Transaction_CardBalance").to_return(:body => '49.99', :headers => { 'Content-Type' => 'application/json' })
      expect(valid_card.card_balance).to eq 49.99
    end
    it "#card returns the card"
    it "#raw_response returns the raw response"
    it "#result returns false if card doesn't exist / has no value"
  end

  context "#add_value" do
    it "#result returns true if successful"
    it "#card returns the card"
    it "#raw_response returns the raw response"
    it "#result returns false if unsuccessful"
  end

  context "#activate_card" do
    it "#result returns true if successsful"
    it "#card returns the card"
    it "#raw_response returns the raw response"
    it "#result returns false if unsuccessful"
  end

  context "#cash_out" do
    it "#result returns amount of cash owed to customer"
    it "#raw_response returns the raw response"
    it "#result returns false if unsuccessful"
  end

  context "#create_card" do
    it "#result returns true if successful"
    it "#card returns the card"
    it "#raw_response returns the raw response"
    it "#result returns false if unsuccessful"
  end

  context "#deactivate_card" do
    it "#result returns true if successful"
    it "#result returns false if unsuccessful"
    it "#raw_response returns the raw response"
  end

  context "#host_totals" do
  end

  context "#replace_card" do
    it "#result returns true if successful"
    it "returns the new card"
    it "#result returns false if unsuccessful"
    it "#raw_response returns the raw response"
  end

  context "#sale" do
    it "#result returns true if successful"
    it "#card returns the card"
    it "#result returns false if unsuccessful"
    it "#raw_response returns the raw response"
  end

  context "#void" do
    it "#result returns true if successful"
    it "#card returns the card"
    it "#result returns false if unsuccessful"
  end

end
