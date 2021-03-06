require_relative 'manufacturer'
require_relative 'instance_counter'

class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :speed, :route, :wagons, :number

  @@all_trains = {}
    
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    @@all_trains[number] = self
    add_instance
  end
  
  def accelerate
    @speed += 5
  end

  def stop
    @speed = 0 
  end

  def add_route(route)
    @route = route
    route.first_station.take_train(self) #почему-то без self не передаётся. Надо выяснить.
    @index_station = 0
  end

  def go_next
    if next_station
      current_station.send_train(self)
      next_station.take_train(self)    
      @index_station += 1
    else
      puts "Это последняя станция"
    end
  end

  def go_previous
    if previous_station
      current_station.send_train(self)
      previous_station.take_train(self)
      @index_station -= 1
    else
      puts "Это первая станция"
    end
  end

  def show_stations
      puts "Текущая станция: #{current_station.station_name}" 
      if next_station
        puts "Следующая станция: #{next_station.station_name}"
      else
        puts "Это последняя станция"
      end
      if previous_station
      puts "Предыдущая станция: #{previous_station.station_name}"
      else
        puts "Это первая станция"
      end
  end

  def add_wagon(wagon)
    if wagon.type == @type
      @wagons.push(wagon)
    end
  end

  def self.find(number)
    if @@all_trains.has_key? number
      puts "Поезд найден -  #{@@all_trains[number]}"
    else
      puts "Поезд не найден"
      return
    end
  end

  private # здесь методы, которые нужны только для работы других методов класса. Нет нужды обращаться к ним напрямую. 

  def current_station
    if @index_station
      route.stations[@index_station] # получаем индекс текущей станции. Если только создали поезд, должен быть равен 0.  
    end
  end

  def next_station
    if @index_station
      route.stations[@index_station + 1] unless @index_station == route.stations.size - 1
    end
  end
  
  def previous_station
    if @index_station
      route.stations[@index_station - 1] unless @index_station == 0
    end
  end


end
