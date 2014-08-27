require 'spec_helper'

describe Valutec do
  let (:valutec) {Valutec}
  it "enables changing of the base_uri" do
    expect(valutec.base_uri).to eq "https://ws.valutec.net/Valutec.asmx"
    expect(valutec.base_uri "https://example.com").to eq "https://example.com"
    expect(valutec.base_uri).to eq "https://example.com"
  end

  describe "::card" do
    context '#card_balance' do
    end
    context '#add_value' do
    end
    context '#activate_card' do
    end
    context '#cash_out' do
    end
    context '#create_card' do
    end
    context '#deactivate_card' do
    end
    context '#host_totals' do
    end
    context '#replace_card' do
    end
    context '#sale' do
    end
    context '#void' do
    end
  end

end
