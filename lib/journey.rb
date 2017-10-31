class Journey

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station=nil
    @exit_station=nil
    @current={}
  end

  def start_journey(station)
    @entry_station=station
    @exit_station=nil
    current = { entry: @entry_station, exit: @exit_station }
  end

  def finish_journey(station)
    @exit_station=station
    return { entry: @entry_station, exit: @exit_station } if @entry_station==nil
    @entry_station=nil
    @exit_station
  end

end
