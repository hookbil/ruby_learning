class CargoWagon < Wagon
  attr_reader :free_volume, :occupied_volume, :volume
  def initialize(volume)
    @volume = volume
    @free_volume = volume
    @occupied_volume = 0
    @type = 'cargo'
  end

  def load_wagon(volume)
    if @free_volume >= volume
      @free_volume -= volume
      @occupied_volume += volume
    else
      puts "В вагоне не хватает места"
    end
  end 

end