require "oystercard"

describe Oystercard do

  let(:station) { double :station }
  let(:journey) { double :journey }

  describe "#balance" do
    it "a new instance of an oystercard has a balance of 0" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#top_up" do
    it 'when topping up a new oystercard with 10, balance increases to 10' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
    it "raises an error when topping up will bring balance over 90" do
      expect { subject.top_up(100) }.to raise_error("Top-up declined! There is a card limit of #{Oystercard::CARD_LIMIT}.")
    end
  end

  describe "#touch_in" do

    it "raises an error if balance is less than minimum fare" do
      expect{subject.touch_in(station)}.to raise_error "You need a balance of at least #{Journey::MIN_FARE} to travel."
    end

    it "deducts penalty fare if touching in while in journey" do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_in(station) }.to change{subject.balance}.by(-Journey::PENALTY_FARE)
    end

  end

  describe "#touch_out" do
    before { subject.top_up(2) }

    it "expects minimum fare to be deducted at touch out if travelling within the same zone" do
      allow(station).to receive(:zone).and_return(1)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change{subject.balance}.by(-Journey::MIN_FARE)
    end

    it "expects penalty_fare to be deducted at touch out if not in journey" do
      expect{ subject.touch_out(station) }.to change{subject.balance}.by(-Journey::PENALTY_FARE)
    end

  end

end
