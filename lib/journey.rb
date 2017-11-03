class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
  end

  def start_journey(station)
    @entry_station = station
    current_journey(nil)
  end

  def finish_journey(exit_station)
    return current_journey(exit_station) unless in_journey?
    @entry_station = nil
    exit_station
  end

  def in_journey?
    @entry_station != nil
  end

  def fare(log)
    return PENALTY_FARE if penalty_due(log)
    MIN_FARE + variable_fare(log)
  end

  private

  def current_journey(exit_station)
    { entry: @entry_station, exit: exit_station }
  end

  def penalty_due(log)
    log.last[:entry].nil? || log.last[:exit].nil?
  end

  def variable_fare(log)
    (log.last[:entry].zone - log.last[:exit].zone).abs
  end

end
