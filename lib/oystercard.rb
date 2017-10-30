class Oystercard

  attr_reader :balance

  CARD_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Top-up declined! There is a card limit of #{CARD_LIMIT}." if check_max_balance(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
  end

  private

  def check_max_balance(top_up_amount)
    @balance + top_up_amount > CARD_LIMIT
  end

end
