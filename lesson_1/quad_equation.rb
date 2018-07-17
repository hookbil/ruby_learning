print "Введите a: "
a = gets.chomp.to_f
print "Введите b: "
b = gets.chomp.to_f
print "Введите c: "
c = gets.chomp.to_f

discr = b**2 - 4 * a * c 

if discr < 0
  puts "Корней нет"
  exit
elsif discr == 0
  puts "Квадратное уравнение имеет 1 корень"
  x = -b / (2 * a)
  puts "Корень равен: #{x}"
else
  puts "Квадратное уравнение имеет 2 корня"
  x1 = (-b + Math.sqrt(discr)) / 2 * a
  x2 = (-b - Math.sqrt(discr)) / 2 * a
  puts "1 корень: #{x1}"
  puts "2 корень: #{x2}"
end