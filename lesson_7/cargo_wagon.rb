class CargoWagon < Wagon
  attr_reader :free_volume, :occupied_volume, :volume
  def initialize(volume)
    @volume = volume
    @free_volume = volume
    @occupied_volume = 0
    @type = 'cargo'
  end

  def load_wagon(volume)
    return if volume > @free_volume
    @free_volume -= volume
    @occupied_volume += volume
  end
end
