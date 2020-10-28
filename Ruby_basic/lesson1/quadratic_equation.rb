#! /usr/bin/env ruby 

puts 'Введите три коэффициента квадратного уравнения - a,b,c:'
members = Array.new(gets.chomp.split(','))
a,b,c = *members.map(&:to_i)

puts "Дискриминант: #{disc = (b**2 - 4 * a * c)}"

if disc > 0
  puts "Первый корень: #{(-1 * b + Math.sqrt(disc) )/(2 * a )},
        второй корень: #{( b + Math.sqrt(disc) * -1)/(2 * a )}"
elsif disc == 0
  puts "Корни уравнения: #{(-1 * b)/(2 * a )} "
else 
  puts "Корней нет"
end
  	
