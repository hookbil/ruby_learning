require_relative 'validation'
require_relative 'accessors'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

train1 = PassengerTrain.new('12312')
puts "Параметры поезда верные? #{train1.valid?}"

begin
  train2 = CargoTrain.new(123)
rescue RuntimeError => error
  puts error
end

begin
  train3 = CargoTrain.new('Aa123-123')
rescue RuntimeError => error
  puts error
end

station1 = Station.new('Msk')
station1.station_name = 'Spb'
puts station1.station_name_history

station1.station_type = 'Cargo'
puts station1.station_type

begin
  station1.station_type = 0
rescue TypeError => error
  puts error
end
