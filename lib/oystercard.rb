class Oystercard

  attr_reader :balance

  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top-up declined! There is a card limit of #{CARD_LIMIT}." if check_max_balance(amount)
    @balance += amount
  end

  private

  def check_max_balance(top_up_amount)
    @balance + top_up_amount > CARD_LIMIT
  end

end
