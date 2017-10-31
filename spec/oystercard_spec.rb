require "oystercard"

describe Oystercard do

  let(:station) {double :station}

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
    it "expects in journey to be true after touching in" do
      subject.top_up(2)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raises an error if balance is less than minimum fare" do
      expect{subject.touch_in(station)}.to raise_error "You need a balance of at least #{Oystercard::MIN_FARE} to travel."
    end
  end

  describe "#touch_out" do
    before { subject.top_up(2) }
    before { subject.touch_in(station) }
    it "expects in journey to be false after touching out" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "expects minimum fare to be deducted at touch out" do
      expect{ subject.touch_out(station) }.to change{subject.balance}.by(-Oystercard::MIN_FARE)
    end
  end

  describe "#journeys" do

    describe "#journeys on initializing" do
        it "check journeys is an array" do
        expect(subject.journeys).to eq([])
      end
    end

    it "stores entry station upon touch_in" do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.journeys.last[:entry]).to eq(station)
    end


    describe "#journey storing entries and exits" do
      before { subject.top_up(10) }
      before { subject.touch_in(station) }
      before { subject.touch_out(station) }

      it "stores entry station and exit station" do
        expect(subject.journeys).to include({ entry: station, exit: station })
      end

      it "checks that touching in and out creates one and only one journey" do
        expect(subject.journeys.count).to eq(1)
      end

    end

  end

end
