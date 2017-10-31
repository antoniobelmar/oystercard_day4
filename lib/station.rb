class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    fail 'Please enter zone number between 1 and 6' unless zone.between?(1, 6)
    @name = name
    @zone = zone
  end

end
