class Route 
  include InstanceCounter
  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    valid! 
    add_instance
  end

  def add_way_station(way_station)
    @stations.insert(-2, way_station)
  end

  def delete_way_station(way_station)
    allow_stations = @stations.slice(1...-1)
    if allow_stations.include?(way_station)
      @stations.delete(way_station)
    end
  end

  def first_station
    @stations.first
  end

  def last_station
    @stations.last
  end

  def valid? 
    valid!
  rescue
    false
  end

  protected

  def valid!
    raise "Это не объект класса Station" if first_station.class != Station
    raise "Это также не объект класса Station" if last_station.class != Station
    true
  end
end
  