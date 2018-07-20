months = [31,28,31,30,31,30,31,31,30,31,30,31]
day_count = 0
count = 0
days_in_month = 0
i = 0
print "Enter date: "
day = gets.chomp.to_i

print "Enter month: "
month = gets.chomp.to_i

print "Enter year: "
year = gets.chomp.to_i

if year % 400 == 0 || year % 4 == 0
  months[1] = 29
end

if month > 1 
  count = month - 1
elsif
  day_count = day_count + day
  puts "Это #{day_count} день в #{year} году."
  exit
end

count.times do |i|
    
  days_in_month = days_in_month + months[i]
  i = i + 1
    
end

day_count = days_in_month + day

puts "Это #{day_count} день в году."