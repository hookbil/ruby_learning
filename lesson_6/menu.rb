class Menu

  attr_accessor :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def add_station
    puts "Введите название станции(больше двух символов): "
    station_name = gets.chomp.capitalize
    begin
    station = Station.new(station_name)
    rescue RuntimeError => error
      puts error
      station_name = nil
      return add_station
    end
    puts "Станция #{station_name} добавлена."
    @stations.push(station)
  end

  def add_train
    puts "Номер должен быть следующего формата: 3 символа a-z1-9, необязательный дефис и ещё два символа a-z1-9. Например a12-34 или a1234"
    print "Введите номер поезда: "
    number = gets.chomp.to_s
    puts "Укажите тип поезда: "
    puts "1. Пассажирский"
    puts "2. Грузовой"
    input = gets.chomp.to_i
    case input
    when 1
      begin
      train = PassengerTrain.new(number)
      rescue RuntimeError => error
        puts error
        number = nil
        return add_train
      end
    when 2
      begin
      train = CargoTrain.new(number)
      rescue RuntimeError => error
        puts error
        number = nil
        return
      end
    else
      puts "Был введён неправильный тип поезда. Попробуйте ещё раз."
    end
    @trains.push(train)
    puts "Поезд номер #{number} создан."
  end

  def stations_info
    if @stations.empty?
      puts "Станций не найдено."
      return
    end
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.station_name}. Поезда: #{station.trains}"
    end
  end

  def add_route
    print_stations
    print "Выберите номер первой станции: "
    first_station_number = gets.chomp.to_i - 1
    station_first = @stations[first_station_number]
    print "Выберите номер последней станции: "
    last_station_number = gets.chomp.to_i - 1
    station_last = @stations[last_station_number]  
    begin
    route = Route.new(station_first,station_last)
    @routes.push(route)
    rescue RuntimeError => error
      puts error
      first_station_number = nil
      last_station_number = nil
      return
    end
    
  end

  def manage_route
    if @routes.empty?
      puts "Добавьте маршрут"
      return
    end    
    print_routes
    route_number = gets.chomp.to_i - 1
    route = @routes[route_number]
    puts "1. Добавить станцию в маршрут 2. Удалить станцию из маршрута"
    choice = gets.chomp.to_i
    case choice
    when 1
      add_station_to_route(route)
    when 2
      delete_station_from_route(route)      
    end
  end

  def train_route # назначить маршрут поезду
    if @trains.empty? 
      puts "Нет поездов"
      return
    end
    if @routes.empty?
      puts "Нет маршрутов"
      return
    end    
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    print_routes
    route_number = gets.chomp.to_i - 1
    route = @routes[route_number]
    train.add_route(route)
  end

  def wagon
    if @trains.count == 0
      puts "Сначала добавьте поезд"
      return
    end      
      print_trains
      train_number = gets.chomp.to_i - 1
      train = @trains[train_number]
      puts "1. Добавить 2. Удалить"
      wagon = gets.chomp.to_i
      if wagon == 1
        add_wagon(train)
      elsif wagon == 2 && train.wagons.count > 0
        delete_wagon(train)
      else
        puts "Что-то пошло не так."
      end    
  end

  def train_go
    if @trains.empty?
      puts "Поездов не найдено."
      return
    end    
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    if train.route == nil
      puts "У выбранного поезда нет маршрута."
      return
    end
    puts "1. Отправить поезд на следующую станцию 2. Отправить поезд на предыдущую станцию"
    answer = gets.chomp.to_i
    if answer == 1
      if train.next_station 
        train.go_next
      else
        puts "Это последняя станция"
      end
    elsif answer == 2
      if train.previous_station
        train.go_previous
      else
        puts "Это первая станция"
      end
    else
      puts "Что-то пошло не так."
      return
    end
  end

  private #Методы ниже нужны только для работы других методов класса. 

  def add_wagon(train)
    wagon = Wagon.new(train.type)
    train.add_wagon(wagon)
    @wagons.push(wagon)
    puts "Вагон добавлен"
  end

  def delete_wagon(train)
    wagon = train.wagons
    wagon.delete_at(-1)
    puts "Вагон удалён"
  end

  def add_station_to_route(route)
    puts "Выберите номер станции: "
    print_stations
    station_number = gets.chomp.to_i - 1
    
    station = @stations[station_number]
    if route.stations.include? station
      puts "Данная станция уже есть на маршруте."
      return
    end
    route.add_way_station(station)
    puts "Станция #{station.station_name} была добавлена."

  end

  def delete_station_from_route(route)
    allow_stations = route.stations.slice(1...-1)
    if allow_stations.empty?
      puts "Нечего удалять."
      return
    else
      puts "Выберите номер станции: "
      allow_stations.each_with_index do |station, index|
        puts "#{index + 1}. #{station.station_name}"
      end
    end
    station_number_to_delete = gets.chomp.to_i
    station_to_delete = route.stations[station_number_to_delete]
    route.delete_way_station(station_to_delete)
    puts "Станция #{station_to_delete.station_name} была удалена."
  end

  def print_stations
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.station_name}"
    end
  end

  def print_routes
    puts "Выберите маршрут: "
    @routes.each_with_index do |route, index|
      puts "#{index + 1}. Откуда: #{route.stations.first.station_name}, куда: #{route.stations.last.station_name}"
    end
  end

  def print_trains
    puts "Выберите поезд: "
    @trains.each_with_index do |train, index|
      puts "#{index + 1}. Номер: #{train.number}, тип: #{train.type}"
      if train.route
        puts "Откуда: #{train.route.stations.first.station_name}, куда: #{train.route.stations.last.station_name}"
      end
    end
  end


end
