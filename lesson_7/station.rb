class Station
  include InstanceCounter
  attr_reader :trains, :station_name

  @@all_stations = []
  
  def self.all
    @@all_stations
  end

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    @@all_stations.push(self)
    validate!
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

  def each_train(&block)
    @trains.each { |train| yield(train)} if @trains.size > 0
  end

  def valid? 
    validate!
  rescue
    false
  end

  protected
  def validate!
    raise "Название должно быть больше двух символов" if station_name.size < 3
    true
  end
end
  
  