@goods = {}
@shopping_cart = 0.0

def add_products(product,price,quantity)
  
  hash = {}
  hash['Цена'] = price
  hash['Количество'] = quantity
  amount = price * quantity
  hash['Итог'] = amount
  @goods[product] = hash
    
end

def calculate_price(amount)

  @shopping_cart = @shopping_cart + amount

end

loop do    
  
  puts "Введите название товара (введите stop\, чтобы отобразить результат)"
  product = gets.chomp
  if product == "stop"
    puts @goods
    puts "Итого: #{@shopping_cart}"
    return
  end

  puts "Введите цену товара"
  price = gets.chomp.to_f

  puts "Введите количество товара: "
  quantity = gets.chomp.to_f
  
  add_products(product, price, quantity)
  amount = @goods[product]["Итог"]
  calculate_price(amount)

end
