class Train
  include Manufacturer
  include InstanceCounter
  attr_reader :speed, :route, :wagons, :number

  def self.all_trains
    @all_trains = {}
  end
  VALID_NUMBER = /^[a-z1-9]{3}-?[a-z1-9]{2}$/i

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
    validate!
    @@all_trains[number] = self
    add_instance
  end

  def valid?
    validate!
  rescue RuntimeError
    false
  end

  def accelerate
    @speed += 5
  end

  def stop
    @speed = 0
  end

  def add_route(route)
    @route = route
    route.first_station.take_train(self)
    @index_station = 0
  end

  def each_wagon(&_block)
    @wagons.each { |wagon| yield(wagon) }
  end

  def go_next
    current_station.send_train(self)
    next_station.take_train(self)
    @index_station += 1
  end

  def go_previous
    current_station.send_train(self)
    previous_station.take_train(self)
    @index_station -= 1
  end

  def add_wagon(wagon)
    return if wagon.type != @type
    @wagons.push(wagon)
  end

  def next_station
    return if @index_station.nil?
    route.stations[@index_station + 1] unless @index_station == route.stations.size - 1
  end

  def previous_station
    return if @index_station.nil?
    route.stations[@index_station - 1] unless @index_station.zero?
  end

  def self.find(number)
    return @all_trains[number] if @all_trains.key? number
  end

  private

  def validate!
    raise 'Номер не может быть пустым' unless number
    raise 'Номер имеет неверный формат' if number !~ VALID_NUMBER
    true
  end

  def current_station
    return route.stations[@index_station] if @index_station
  end
end
