class Menu
  attr_accessor :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end

  def add_station
    puts 'Введите название станции(больше двух символов): '
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
    puts 'Номер должен быть следующего формата: '
    print '3 символа a-z1-9, необязательный дефис и ещё два символа a-z1-9. '
    puts 'Например a12-34 или a1234'
    puts 'Введите номер поезда: '
    number = gets.chomp.to_s
    puts 'Укажите тип поезда: '
    puts '1. Пассажирский'
    puts '2. Грузовой'
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
      puts 'Был введён неправильный тип поезда. Попробуйте ещё раз.'
    end
    @trains.push(train)
    puts "Поезд номер #{number} создан."
  end

  def stations_info
    if @stations.empty?
      puts 'Станций не найдено.'
      return
    end
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.station_name}. Поезда: #{station.trains}"
    end
  end

  def add_route
    print_stations
    print 'Выберите номер первой станции: '
    first_station_number = gets.chomp.to_i - 1
    station_first = @stations[first_station_number]
    print 'Выберите номер последней станции: '
    last_station_number = gets.chomp.to_i - 1
    station_last = @stations[last_station_number]
    begin
      route = Route.new(station_first, station_last)
      @routes.push(route)
    rescue RuntimeError => error
      puts error
      return
    end
  end

  def manage_route
    if @routes.empty?
      puts 'Добавьте маршрут'
      return
    end
    print_routes
    route_number = gets.chomp.to_i - 1
    route = @routes[route_number]
    puts '1. Добавить станцию в маршрут 2. Удалить станцию из маршрут'
    choice = gets.chomp.to_i
    case choice
    when 1
      add_station_to_route(route)
    when 2
      delete_station_from_route(route)
    end
  end

  def train_route
    if @trains.empty?
      puts 'Нет поездов'
      return
    end
    if @routes.empty?
      puts 'Нет маршрутов'
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
    if @trains.count.zero?
      puts 'Сначала добавьте поезд'
      return
    end
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    puts '1. Добавить 2. Удалить'
    wagon = gets.chomp.to_i
    if wagon == 1
      add_wagon(train)
    elsif wagon == 2 && train.wagons.count > 0
      delete_wagon(train)
    else
      puts 'Что-то пошло не так.'
    end
  end

  def train_go
    return puts 'Поездов не найдено' if @trains.empty?
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    return puts 'У выбранного поезда нет маршрута.' if train.route.nil?
    puts '1. Отправить поезд на следующую станцию 2. Отправить поезд на предыдущую станцию'
    answer = gets.chomp.to_i
    if answer == 1
      if train.next_station
        train.go_next
      else
        puts 'Это последняя станция'
      end
    elsif answer == 2
      if train.previous_station
        train.go_previous
      else
        puts 'Это первая станция'
      end
    else
      puts 'Что-то пошло не так.'
      return
    end
  end

  def show_wagons_info
    return puts 'Нет поездов' if @trains.empty?
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    i = 0
    train.each_wagon do |wagon|
      if train.type == 'passenger'
        puts "#{i += 1}. Всего мест: #{wagon.seat_count}. Занято: #{wagon.busy_seat}. Свободно: #{wagon.free_seat}."
      else
        puts "#{i += 1}. Общий объём: #{wagon.volume}. Занято: #{wagon.occupied_volume}. Свободно: #{wagon.free_volume}"
      end
    end
  end

  def show_trains_info
    return puts 'Нет станций' if @stations.empty?
    print_stations
    station_number = gets.chomp.to_i - 1
    station = @stations[station_number]
    i = 0
    station.each_train do |train|
      puts "#{i += 1}. Номер: #{train.number}. Тип: #{train.type}"
    end
  end

  def wagon_settings
    return puts 'Нет поездов' if @trains.empty?
    print_trains
    train_number = gets.chomp.to_i - 1
    train = @trains[train_number]
    return puts 'У данного поезда нет вагонов' if train.wagons.empty?
    i = 0
    puts 'Выберите вагон: '
    train.wagons.each do |wagon|
      puts "#{i += 1}. #{wagon}"
    end
    wagon_number = gets.chomp.to_i - 1
    wagon = train.wagons[wagon_number]
    if train.type == 'passenger'
      puts "Свободно мест: #{wagon.free_seat}"
      print 'Введите количество мест, которые вы хотите занять в вагоне: '
      seats = gets.chomp.to_i
      return puts 'В вагоне недостаточно мест' if seats > wagon.free_seat
      wagon.buy_ticket(seats)
      puts "#{seats} мест(а) теперь ваши"
    else
      puts "Свободный объем в вагоне: #{wagon.free_volume}"
      print 'Введите объем, который необходимо занять в вагоне: '
      volume = gets.chomp.to_i
      return puts 'В вагоне недостаточно места' if volume > wagon.free_volume
      wagon.load_wagon(volume)
      puts "Вы заняли #{volume} кубометров объема"
    end
  end

  private

  def add_wagon(train)
    if train.type == 'passenger'
      add_passenger_wagon(train)
    else
      add_cargo_wagon(train)
    end
  end

  def add_passenger_wagon(train)
    print 'Введите количество мест в вагоне: '
    seat_count = gets.chomp.to_i
    return puts 'Введите число больше нуля' if seat_count <= 0
    wagon = PassengerWagon.new(seat_count)
    puts wagon.type
    train.add_wagon(wagon)
    @wagons.push(wagon)
    puts "Был добавлен пассажирский вагон поезду #{train.number}"
  end

  def add_cargo_wagon(train)
    print 'Введите объём вагона: '
    volume = gets.chomp.to_i
    return puts 'Введите число больше нуля' if volume <= 0
    wagon = CargoWagon.new(volume)
    train.add_wagon(wagon)
    @wagons.push(wagon)
    puts "Был добавлен грузовой вагон поезду #{train.number}"
  end

  def delete_wagon(train)
    wagon = train.wagons
    wagon.delete_at(-1)
    puts 'Вагон удалён'
  end

  def add_station_to_route(route)
    puts 'Выберите номер станции: '
    print_stations
    station_number = gets.chomp.to_i - 1
    station = @stations[station_number]
    return puts 'Станция есть на маршруте' if route.stations.include? station
    route.add_way_station(station)
    puts "Станция #{station.station_name} была добавлена."
  end

  def delete_station_from_route(route)
    allow_stations = route.stations.slice(1...-1)
    return puts 'Нечего удалять.' if allow_stations.empty?
    puts 'Выберите номер станции: '
    allow_stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.station_name}"
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
    puts 'Выберите маршрут: '
    @routes.each_with_index do |route, index|
      puts "#{index + 1}. Откуда: #{route.stations.first.station_name}, куда: #{route.stations.last.station_name}"
    end
  end

  def print_trains
    puts 'Выберите поезд: '
    @trains.each_with_index do |train, index|
      puts "#{index + 1}. Номер: #{train.number}, тип: #{train.type}"
      puts "Откуда: #{train.route.stations.first.station_name}, куда: #{train.route.stations.last.station_name}" if train.route
    end
  end
end
