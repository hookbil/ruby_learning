class Station
  include InstanceCounter
  attr_reader :trains, :station_name

  @@all_stations = []
  
  def self.all
    @@all_stations
  end
  def initialize(station_name)
    @station_name = station_name
    @trains=[]
    @@all_stations.push(self)
    add_instance
  end


  def take_train(train)
    @trains.push(train)
  end

  def type_of_trains(type)
    @trains.select { |train| train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end
  
  