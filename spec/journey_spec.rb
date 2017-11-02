require "journey"

describe Journey do

  let(:station) { double(:station) }
  let(:card) { double(:oystercard) }
  let(:log) { double(:journeylog) }
  let(:station2) { double(:station) }

  describe "#start_journey" do
    it "always returns a hash with the argument as entry station and nil as exit station" do
      subject.finish_journey(station)
      expect(subject.start_journey(station)).to eq({ entry: station, exit: nil })
    end
  end

  describe "#finish_journey" do
    it "change exit_station into station passed as argument" do
      expect(subject.finish_journey(station)).to eq({ entry: nil, exit: station })
    end

    it "changes entry_station to nil when called" do
      subject.start_journey(station)
      subject.finish_journey(station)
      expect(subject.send(:current_journey,station)[:entry]).to eq nil
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
    it "ensures fare returns min_fare if travelling between the same zone" do
      allow(log).to receive(:journey_log).and_return([{ entry: station, exit: station }])
      allow(station).to receive(:zone).and_return(1)
      expect(subject.fare(log.journey_log)).to eq(Journey::MIN_FARE)
    end

    it "ensures fare returns 2 if travelling between zones 2 and 3" do
      allow(log).to receive(:journey_log).and_return([{ entry: station, exit: station2 }])
      allow(station).to receive(:zone).and_return(2)
      allow(station2).to receive(:zone).and_return(3)
      expect(subject.fare(log.journey_log)).to eq(2)
    end

    it "ensures fare returns 3 if travelling between zones 6 and 4" do
      allow(log).to receive(:journey_log).and_return([{ entry: station, exit: station2 }])
      allow(station).to receive(:zone).and_return(6)
      allow(station2).to receive(:zone).and_return(4)
      expect(subject.fare(log.journey_log)).to eq(3)
    end

    it "ensures fare returns penalty_fare if no entry/exit station in journey history" do
      allow(log).to receive(:journey_log).and_return([{ entry: nil }])
      expect(subject.fare(log.journey_log)).to eq(Journey::PENALTY_FARE)
    end
  end
end
