arr = []

a = 0
b = 1


loop do
  a = a + b
  b = a + b 
  if a < 100
    arr.push(a)
  end
  if b < 100
    arr.push(b)
  end
  if a + b > 100
    print arr
    exit
  end
end
