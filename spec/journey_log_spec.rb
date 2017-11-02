require "journey_log"

describe JourneyLog do

  let (:station) { double(:station) }

  describe "#initialize" do
    it "initializes with a journey instance variable" do
      expect(subject).to respond_to(:journey)
    end

    it "initializes with a journey_log variable that is an array" do
      expect(subject.journey_log).to be_kind_of(Array)
    end
  end

  describe "#start" do
    it "stores entry station as argument and exit station as nil when touching in " do
      subject.start(station)
      expect(subject.journey_log.last).to eq( { entry: station, exit: nil} )
    end
  end

  describe "#finish" do
    it "stores exit station as argument and entry station as nil when touching out and not touching in" do
      subject.finish(station)
      expect(subject.journey_log.last).to eq( { entry: nil, exit: station} )
    end

    it "stores entry and exit stations when touching in and out" do
      subject.start("station1")
      subject.finish("station2")
      expect(subject.journey_log.last).to eq( { entry: "station1", exit: "station2"} )
    end
  end

end
