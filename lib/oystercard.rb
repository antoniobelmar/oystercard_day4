require_relative "journey"

class Oystercard

  attr_reader :balance, :journey_history

  CARD_LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Top-up declined! There is a card limit of #{CARD_LIMIT}." if check_max_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "You need a balance of at least #{Oystercard::MIN_FARE} to travel." if check_min_fare
    @journey_history << @journey.start_journey(station)
  end

  def in_journey?
    @journey.in_journey?
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey_history << @journey.finish_journey(station) unless in_journey?
    @journey_history.last[:exit] = @journey.finish_journey(station) if in_journey?
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
