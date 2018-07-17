print "Привет! Это программа для рассчёта идеального веса. Введите ваше имя:  "
name = gets.chomp.capitalize

print "Введите ваш рост: "
height = gets.chomp.to_i

perfect_weight = height - 110

if perfect_weight <= 0
  puts "#{name}, у вас идеальный вес"
elsif
  puts "#{name}, идеальный вес для вас - #{perfect_weight}кг"
end