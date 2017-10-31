class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    @entry_station = station
    @exit_station = nil
    current_journey
  end

  def finish_journey(station)
    @exit_station = station
    return current_journey unless in_journey?
    @entry_station = nil
    @exit_station
  end

  def current_journey
    { entry: @entry_station, exit: @exit_station }
  end

  def in_journey?
    @entry_station != nil
  end

  def fare(card)
    return PENALTY_FARE if card.journey_history.last[:entry] == nil || card.journey_history.last[:exit] == nil
    MIN_FARE
  end
end
