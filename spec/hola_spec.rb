# frozen_string_literal: true

require "spec_helper"
require "hola"

RSpec.describe Hola::CLI do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::CLI)
  end

end
