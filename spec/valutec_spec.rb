'spec_helper'

describe Valutec do
  let (:valutec) {Valutec}
  it "enables changing of the base_uri" do
    expect(valutec.base_uri).to eq "https://ws.valutec.net/Valutec.asmx"
    expect(valutec.base_uri "https://example.com").to eq "https://example.com"
    expect(valutec.base_uri).to eq "https://example.com"
  end

  describe "::card" do
    context "#card_balance" do
      it "#result returns the remaining balance of the card"
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

end
