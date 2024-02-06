# frozen_string_literal: true

require "spec_helper"
require "hola/offer/no_offer"

RSpec.describe Hola::Offer::NoOffer do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Offer::NoOffer)
  end

  it_behaves_like :offer
end
