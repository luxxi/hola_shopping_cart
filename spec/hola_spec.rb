# frozen_string_literal: true

require "spec_helper"
require "hola"
require "hola/app"

RSpec.describe Hola::CLI do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::CLI)
  end

  describe "#start" do
    subject { described_class.start }

    let(:app) { instance_double(Hola::App) }

    before do
      allow(Hola::App).to receive(:new).and_return(app)
      allow(app).to receive(:run)
    end

    it "creates app" do
      subject
      expect(app).to have_received(:run)
    end
  end
end
