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
  attr_reader :route, :first_station, :last_station
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route = []
    @route.push(@first_station).push(@last_station)
    
  end

  def add_way_station(way_station)
    @route.insert(-2,way_station)
  end

  def delete_way_station(way_station)
    allow_stations = @route.slice(1...-1)
    if allow_stations.include?way_station
      @route.delete(way_station)
    end
    
  end

  def first_station
    @route.first
  end

  def last_station
    @route.last
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


  def car(action)
    if @speed == 0
      if action == "add"
        @cars += 1
      else
        if @cars >= 1
          @cars -= 1
        end
      end
    end
  end

  def add_route(route)
    @route = route
    route.first_station.take_train(self) #почему-то без self не передаётся. Надо выяснить.
    @index_station = 0
  end

  def go_next
    current_station.send_train(self)
    next_station.take_train(self)
    
    @index_station += 1

  end

  def go_to_previous
    current_station.send_train(self)
    previous_station.take_train(self)
    @index_station -= 1

  end

  def current_station
    route.route[@index_station] # получаем индекс текущей станции. Если только создали поезд, должен быть равен 0.
  end

  def next_station
    route.route[@index_station + 1] unless @index_station == route.route.size - 1
  end
  
  def previous_station
    route.route[@index_station - 1] unless @index_station == route.route.size 
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

