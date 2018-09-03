class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, VALID_NUMBER
  validate :number, :type, String
  attr_reader :type

  def initialize(number)
    @type = 'cargo'
    super
  end
end
