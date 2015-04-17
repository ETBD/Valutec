require 'spec_helper'

describe Valutec::Card do
  let (:valid_card) {Valutec::Card.new({card_number: '1234-1234-1234-1234-123'})}
  let (:invalid_card) {Valutec::Card.new({card_number: '6666-6666-6666-6666-123'})}

  context '#card_balance' do
    it "#result returns card balance as a float if exists" do
      stub_request(:any, /.*Transaction_CardBalance.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_balance.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.card_balance.result).to eq 50.00
    end
    it "#card returns the card" do
      stub_request(:any, /.*Transaction_CardBalance.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_balance.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.card_balance.card).to eq valid_card
    end
    it "#raw_response returns the raw response" do
      stub_request(:any, /.*Transaction_CardBalance.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_balance.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.card_balance.raw_response.class).to eq HTTParty::Response
    end
    it "#result returns 0.0 if card has no value"  do
      stub_request(:any, /.*Transaction_CardBalance.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_balance_empty_card.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.card_balance.result).to eq 0.0
    end
    it "#result returns 0.0 if card doesn't exist"  do
      stub_request(:any, /.*Transaction_CardBalance.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_card_not_found.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.card_balance.result).to eq 0.0
    end
  end

  context "#add_value" do
    it "#result returns true if successful" do
      stub_request(:any, /.*Transaction_AddValue.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_add_value.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.add_value(5).result).to eq true
    end
    it "#card returns the card" do
      stub_request(:any, /.*Transaction_AddValue.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_add_value.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.add_value(5).card).to eq valid_card
    end
    it "#raw_response returns the raw response" do
      stub_request(:any, /.*Transaction_AddValue.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_add_value.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.add_value(5).raw_response.class).to eq HTTParty::Response
    end
    it "#result returns false if unsuccessful" do
      stub_request(:any, /.*Transaction_AddValue.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_card_not_found.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.add_value(5).result).to eq false
    end
  end

  context "#create_card" do
    it "#result returns true if successsful" do
      stub_request(:any, /.*Transaction_CreateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_creation.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.create_card(5).result).to eq true
    end
    it "#card returns the card" do
      stub_request(:any, /.*Transaction_CreateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_creation.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.create_card(5).card.card_number).to eq 123456789123456789
    end
    it "#raw_response returns the raw response" do
      stub_request(:any, /.*Transaction_CreateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_creation.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.create_card(5).raw_response.class).to eq HTTParty::Response
    end
    it "#result returns false if unsuccessful" do
      stub_request(:any, /.*Transaction_CreateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_duplicate_transaction.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.create_card(5).raw_response.class).to eq HTTParty::Response
    end
    it "#card returns nil if unsuccessful" do
       stub_request(:any, /.*Transaction_CreateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_duplicate_transaction.xml"), :headers => { 'Content-Type' => 'application/xml' })
       expect(valid_card.create_card(5).card).to be_nil
    end
  end

  context "#cash_out" do
    it "#result returns amount of cash owed to customer"
    it "#raw_response returns the raw response"
    it "#result returns false if unsuccessful"
  end

  context "#deactivate_card" do
    it "#result returns true if successful"
    it "#result returns false if unsuccessful"
    it "#raw_response returns the raw response"
  end

  context "#activate_card" do
    it "#result returns true if successful" do
      stub_request(:any, /.*Transaction_ActivateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_activate_card.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(Valutec::Card.new(card_number: 1999999999).activate_card(50.00).result).to eq true
    end
    it "#result returns false if unsuccessful" do
      pending # no way to test this atm
      stub_request(:any, /.*Transaction_ActivateCard.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_activate.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(Valutec::Card.new(card_number: 1999999999).activate_card(199999999999999,50.00).result).to eq false
    end
    it "#raw_response returns the raw response" do
      pending
    end
  end

  context "#host_totals" do
    it "Does things"
  end

  context "#replace_card" do
    it "#result returns true if successful"
    it "#card returns the new card"
    it "#result returns false if unsuccessful"
    it "#raw_response returns the raw response"
  end

  context "#sale" do
    it "#result returns true if successful" do
      stub_request(:any, /.*Transaction_Sale.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_sale_25.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.sale(25).result).to eq true
    end
    it "#card returns the card" do
      stub_request(:any, /.*Transaction_Sale.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_sale_25.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.sale(25).card).to eq valid_card
    end
    it "#result returns false if unsuccessful" do
      stub_request(:any, /.*Transaction_Sale.*/).to_return(:body => File.read("spec/valutec/valutec_responses/unsuccessful_sale_nsf.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.sale(50).card).to eq valid_card
    end
    it "#raw_response returns the raw response" do
      stub_request(:any, /.*Transaction_Sale.*/).to_return(:body => File.read("spec/valutec/valutec_responses/successful_card_balance.xml"), :headers => { 'Content-Type' => 'application/xml' })
      expect(valid_card.sale(50).raw_response.class).to eq HTTParty::Response
    end
  end

  context "#void" do
    it "#result returns true if successful"
    it "#card returns the card"
    it "#result returns false if unsuccessful"
  end

end
