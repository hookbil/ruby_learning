@arr = [0,1]

while @arr.last < 100 do
  
  @fibo = @arr[-1] + @arr[-2]
  
  if @fibo > 100
    print @arr
    exit
  end
    
  if @arr[-1] < 100
    @arr.push(@fibo)

  end
end

