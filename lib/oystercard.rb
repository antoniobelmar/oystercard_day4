class Oystercard

  attr_reader :balance, :entry_station, :journeys

  CARD_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Top-up declined! There is a card limit of #{CARD_LIMIT}." if check_max_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "You need a balance of at least #{Oystercard::MIN_FARE} to travel." if check_min_fare
    @entry_station = station
  end

  def in_journey?
    return true unless @entry_station == nil
    false
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journeys << { entry: @entry_station, exit: station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def check_max_balance(top_up_amount)
    @balance + top_up_amount > CARD_LIMIT
  end

  def check_min_fare
    @balance < MIN_FARE
  end

end
