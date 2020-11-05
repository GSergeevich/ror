#!/usr/bin/env ruby

puts 'Вводите значения для наполнения корзины товарами, для завершения наберите "стоп" '

cart = {}

loop do
  puts 'Введите название товара (или "стоп") :'
  product = gets.chomp
  break if  product == 'стоп'

  puts 'Введите цену товара:'
  price = gets.chomp
  puts 'Введите количество товаров:'
  number = gets.chomp
  product = product.to_sym
  cart[product] = { price: price.to_f, number: number.to_i }
end

puts 'Итоговая цена для каждого товара в корзине:'
cart.each { |product, info| puts "#{product} : #{info[:subtotal] = info[:price] * info[:number]}" }

puts 'Итого:'
p cart.values.reduce(0) { |m, value| value[:subtotal] + m }
