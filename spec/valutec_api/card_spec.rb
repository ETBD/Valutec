require 'spec_helper'

describe ValutecApi::Card do
  let (:valid_card) {ValutecApi::Card.new({card_number: '1234123412341234'})}
  let (:invalid_card) {ValutecApi::Card.new({card_number: '6666666666666666'})}

  it "raises if client_key and terminal_id are not specified" do
    expect{ValutecApi::Card.new({client_key: '1234',terminal_id: '4321'})}.to_not raise_error
    expect{ValutecApi::Card.new({client_key: '1234'})}.to raise_error
    expect{ValutecApi::Card.new({terminal_id: '4321'})}.to raise_error
    expect{ValutecApi::Card.new}.to raise_error

    ENV['VALUTEC_TERMINAL_ID'] = "derp"
    ENV['VALUTEC_CLIENT_KEY'] = "doop"

    expect{ValutecApi::Card.new({client_key: '1234',terminal_id: '4321'})}.to_not raise_error
    expect{ValutecApi::Card.new({client_key: '1234'})}.to_not raise_error
    expect{ValutecApi::Card.new({terminal_id: '4321'})}.to_not raise_error
    expect{ValutecApi::Card.new}.to_not raise_error
  end

  context '#card_balance' do
    it "returns card balance as a float if exists" do
      expect(valid_card.card_balance).to eq 49.99
    end

    it "returns false if card not exist" do
      # expect(.card_balance).to be_false
    end
  end

  context '#add_value' do
    it "returns new balance as float if successful"
    it "returns false if unsuccessful"
  end

  context "#activate_card" do
    it "returns things"
  end

  context "#cash_out" do
    it "returns stuff"
  end

  context "#deactivate_card" do
    it "derps"
  end

  context "#host_totals" do
    it "?????"
  end

  context "#replace_card" do
    it "who knows"
  end

  context "#sale" do
    it "transaction-a-fies"
  end

  context "#void" do
    it "hi"
  end

end
