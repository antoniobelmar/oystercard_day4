require_relative "journey"

class JourneyLog
  attr_reader :journey_log

  def initialize
    @journey = Journey.new
    @journey_log = []
  end

  def start(entry_station)
    @journey_log << @journey.start_journey(entry_station)
  end

  def finish(exit_station)
    return @journey_log << @journey.finish_journey(exit_station) unless in_journey?
    @journey_log.last[:exit] = @journey.finish_journey(exit_station)
  end

  def fare
    @journey.fare(self.journey_log)
  end

  def in_journey?
    @journey.in_journey?
  end

end
