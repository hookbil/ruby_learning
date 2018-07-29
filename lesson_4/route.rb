class Route 
    attr_reader :stations, :first_station, :last_station
    def initialize(first_station, last_station)
      @stations = [first_station, last_station] 
    end
  
    def add_way_station(way_station)
      @stations.insert(-2,way_station)
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
  
end
  