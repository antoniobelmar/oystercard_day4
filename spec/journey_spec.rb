require "journey"

describe Journey do

  let(:station) { double(:station) }
  let(:card) { double(:oystercard) }

  describe "#entry_station" do
    it "shows nil as entry station when calling entry_station on new journey" do
      expect(Journey.new.entry_station).to eq nil
    end
  end

  describe "#exit_station" do
    it "shows nil as exit station when calling entry_station on new journey"do
      expect(Journey.new.exit_station).to eq nil
    end
  end

  describe "#start_journey" do
    it "change entry_station into station passed as argument" do
      subject.start_journey(station)
      expect(subject.entry_station).to eq(station)
    end

    it "changes exit_station to nil when called" do
      subject.finish_journey(station)
      subject.start_journey(station)
      expect(subject.exit_station).to eq nil
    end

    it "always returns a hash with the argument as entry station and nil as exit station" do
      expect(subject.start_journey(station)).to eq({entry:station, exit:nil})
    end
  end

  describe "#finish_journey" do
    it "change exit_station into station passed as argument" do
      subject.finish_journey(station)
      expect(subject.exit_station).to eq(station)
    end

    it "changes entry_station to nil when called" do
      subject.start_journey(station)
      subject.finish_journey(station)
      expect(subject.entry_station).to eq nil
    end

    it "returns a hash with the argument as exit station and nil as entry station if entry_station=nil" do
      subject.finish_journey(station)
      expect(subject.finish_journey(station)).to eq({entry:nil, exit:station})
    end

    it "returns exit_station if entry_station is not new initially " do
      subject.start_journey("bank")
      expect(subject.finish_journey(station)).to eq(station)
    end
  end

  describe "#in_journey?" do
    it "ensures calling in_journey? on an instance returns false if entry station is nil" do
      expect(subject.in_journey?).to eq false
    end

    it "ensures calling in_journey? on an instance returns true if entry station is not nil" do
      subject.start_journey(station)
      expect(subject.in_journey?).to eq true
    end
  end

  describe "#fare" do
    it "ensures fare returns min_fare if entry and exit station in journey history" do
      allow(card).to receive(:journey_history).and_return([{ entry: 1, exit: 1 }])
      expect(subject.fare(card)).to eq(Journey::MIN_FARE)
    end
    it "ensures fare returns penalty_fare if no entry/exit station in journey history" do
      allow(card).to receive(:journey_history).and_return([{ entry: nil }])
      expect(subject.fare(card)).to eq(Journey::PENALTY_FARE)
    end
  end

  describe "#current_journey" do
    it "ensures current journey returns a hash with current entry and exit stations" do
      subject.start_journey(station)
      expect(subject.current_journey).to eq( { entry: station, exit: nil } )
    end
  end
end
