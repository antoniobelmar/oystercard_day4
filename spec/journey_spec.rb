require "journey"

describe Journey do

  let(:station) { double(:station) }

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

end
