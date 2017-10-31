class Journey

  attr_reader :entry_station, :exit_station

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
    return current_journey if in_journey?
    @entry_station = nil
    @exit_station
  end

  def current_journey
    { entry: @entry_station, exit: @exit_station }
  end

  def in_journey?
    @entry_station != nil
  end

  def fare
    if in_journey?
      if @entry_station == nil
        1
      else
        6
      end
    else
      6
    end
  end

end
