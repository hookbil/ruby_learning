require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'menu'

menu = Menu.new

loop do
  puts ""
  puts "Что вы хотите сделать?"
  puts "1. Добавить станцию"
  puts "2. Добавить поезд"
  puts "3. Добавить маршрут"
  puts "4. Настройки маршрута"
  puts "5. Назначить маршрут поезду"
  puts "6. Добавить или удалить вагон"
  puts "7. Отправить поезд по маршруту"
  puts "8. Показать список станций и поезда на них."
  puts "999. Выход"
  a = gets.chomp.to_i
  case a
  when 1
    menu.add_station
  when 2
    menu.add_train
  when 3
    menu.add_route
  when 4
    menu.manage_route
  when 5
    menu.train_route
  when 6
    menu.wagon
  when 7
    menu.train_go
  when 8
    menu.stations_info

  when 999
    exit
  when 0
    return
  end
end
