@goods = {}
@shopping_cart = 0.0

def add_product
    
    
  hash = {}
  puts "Введите название товара (введите \"стоп\"\, чтобы отобразить результат)"
  @product = gets.chomp.capitalize
  if @product == "Стоп"
    puts @goods
    puts "Итого: #{@shopping_cart}"
    exit
  end


  puts "Введите цену товара"
  @price = gets.chomp.to_f
  hash['Цена'] = @price
  puts "Введите количество товара: "
  @quantity = gets.chomp.to_f
  hash['Количество'] = @quantity
    
  amount = @price * @quantity
  hash['Итог'] = amount

  @goods[@product] = hash
  @shopping_cart = @shopping_cart + @goods[@product]["Итог"]
    
end


loop do    
  add_product    
end
