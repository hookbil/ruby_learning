@arr = [0,1]

while @arr.last + @arr[-2] < 100 do
  fibo = @arr[-1] + @arr[-2]
  @arr.push(fibo)
end

print @arr