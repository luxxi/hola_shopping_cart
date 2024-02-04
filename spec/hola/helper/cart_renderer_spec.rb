# frozen_string_literal: true

require "spec_helper"
require "hola/helper/cart_renderer"
require "tty-prompt"
require "tty/prompt/test"

RSpec.describe Hola::Helper::CartRenderer do
  it "is available as described_class" do
    expect(described_class).to eq(Hola::Helper::CartRenderer)
  end

  describe ".perform" do
    subject { described_class.new.perform }

    let(:table) { instance_double(TTY::Table) }
    before do
      allow(TTY::Table).to receive(:new).and_return(table)
      allow(table).to receive(:render)
    end

    it "renders cart output" do
      subject
      expect(table).to have_received(:render)
    end
  end
end