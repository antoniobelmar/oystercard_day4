require_relative "journey_log"

class Oystercard

  attr_reader :balance, :journey_log

  CARD_LIMIT = 90

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "Top-up declined! There is a card limit of #{CARD_LIMIT}." if check_max_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "You need a balance of at least #{Journey::MIN_FARE} to travel." if check_min_fare
    deduct(@journey_log.fare) if in_journey?
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct(@journey_log.fare)
  end

  private

  def in_journey?
    @journey_log.in_journey?
  end

  def deduct(amount)
    @balance -= amount
  end

  def check_max_balance(top_up_amount)
    @balance + top_up_amount > CARD_LIMIT
  end

  def check_min_fare
    @balance < Journey::MIN_FARE
  end

end
