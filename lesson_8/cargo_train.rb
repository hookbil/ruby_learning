class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = 'cargo'
    super
  end
end
