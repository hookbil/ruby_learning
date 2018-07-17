print "Введите a: "
a = gets.chomp.to_f
print "Введите b: "
b = gets.chomp.to_f
print "Введите c: "
c = gets.chomp.to_f

teorema = a**2 + b**2 == c**2
if teorema == true
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный"
end

if a == b && b == c 
  puts "Треугольник равносторонний и равнобедренный"
elsif a == b || b == c || c == a
  puts "Треугольник равнобедренный"
end