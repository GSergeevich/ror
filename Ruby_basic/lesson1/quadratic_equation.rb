#! /usr/bin/env ruby 

puts 'Введите три коэффициента квадратного уравнения - a,b,c:'
members = Array.new(gets.chomp.split(','))
a,b,c = *members.map(&:to_f)

puts "Дискриминант: #{disc = (b**2 - 4 * a * c)}"


if disc.positive?
  disc_sqrt = Math.sqrt(disc)
  puts "Первый корень: #{(-1 * b + disc_sqrt )/(2 * a )},"
  puts "второй корень: #{( b + disc_sqrt * -1)/(2 * a )}"
elsif disc.zero?
  puts "Корни уравнения: #{(-1 * b)/(2 * a )} "
else 
  puts "Корней нет"
end
