require "oystercard"

describe Oystercard do

  describe "#balance" do
    it "responds to balance method" do
      expect(subject).to respond_to(:balance)
    end

    it "a new instance of an oystercard has a balance of 0" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it 'responds to top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
    it 'when topping up a new oystercard with 10, balance increases to 10' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
    it "raises an error when topping up will bring balance over 90" do
      expect { subject.top_up(100) }.to raise_error("Top-up declined! There is a card limit of #{Oystercard::CARD_LIMIT}.")
    end
  end
end
