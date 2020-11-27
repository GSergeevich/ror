#! /usr/bin/env ruby

puts 'Как вас зовут?'
username = gets.chomp
puts 'Каков ваш рост в см?'
heigth = gets.chomp.to_i

weight = (heigth - 110 ) * 1.15
if weight  > 0 
  puts "#{username} , ваш идеальный вес #{weight.round} кг."
else
  puts "#{username} , ваш вес уже оптимален."
end


