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
    it "returns card balance as a float if exists" do
      stub_request(:get, "https://ws.valutec.net/Valutec.asmx/Transaction_CardBalance").to_return(:body => '49.99', :headers => { 'Content-Type' => 'application/json' })
      expect(valid_card.card_balance).to eq 49.99
    end

    it "returns false if card not exist, or has no balance" do
      # expect(.card_balance).to be_false
    end
  end

  context '#add_value' do
    it "returns new balance as float if successful"
    it "returns false if unsuccessful"
  end

  context "#activate_card" do
    it "returns true if activation successful"
    it "returns false if unsuccessful"
  end

  context "#cash_out" do
    it "returns the amount to be paid if successful"
    it "returns false if unsuccessful"
  end

  context "#deactivate_card" do
    it "returns the amount to be paid if successuful"
    it "returns false if unsuccessful"
  end

  context "#host_totals" do
    it "?????"
  end

  context "#replace_card" do
    it "who knows"
  end

  context "#sale" do
    it "returns true if successfully charged"
    it "returns false if not successfully charged"
  end

  context "#void" do
    it "returns true if successfully voided"
    it "returns false if not successfully voided"
  end

end
