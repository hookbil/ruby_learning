class Station
  attr_reader :trains, :station_name
  def initialize(station_name)
    @station_name = station_name
    @trains=[]
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

class Train
  attr_accessor :speed, :type, :route
  
  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = 0
  end

  def accelerate
    self.speed += 5
  end

  def stop
    self.speed = 0 
  end

  def add_car
    if @speed == 0
      @cars += 1
    end
  end

  def delete_car
    if @speed == 0 && @cars > 0
      @cars -= 1
    end
  end
  def add_route(route)
    @route = route
    route.first_station.take_train(self) #почему-то без self не передаётся. Надо выяснить.
    @index_station = 0
  end

  def go_next
    if next_station != nil
      current_station.send_train(self)
      next_station.take_train(self)    
      @index_station += 1
    else
      puts "Это последняя станция"
    end
  end

  def go_previous
    if previous_station != nil
      current_station.send_train(self)
      previous_station.take_train(self)
      @index_station -= 1
    else
      puts "Это первая станция"
    end
  end

  def current_station
    route.stations[@index_station] # получаем индекс текущей станции. Если только создали поезд, должен быть равен 0.
  end

  def next_station
    route.stations[@index_station + 1] unless @index_station == route.stations.size - 1
  end
  
  def previous_station
    route.stations[@index_station - 1] unless @index_station == route.stations.size 
  end

  def show_stations
    puts "Текущая станция: #{current_station.station_name}" 
    if next_station != nil
      puts "Следующая станция: #{next_station.station_name}"
    else
      puts "Это последняя станция"
    end
    if previous_station != nil
    puts "Предыдущая станция: #{previous_station.station_name}"
    else
      puts "Это первая станция"
    end
  end
end

