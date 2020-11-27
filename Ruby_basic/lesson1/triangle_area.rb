#! /usr/bin/env ruby

puts 'Введите длину основания треугольника:'
base = gets.chomp.to_i
puts 'Введите высоту треугольника:'
height = gets.chomp.to_i
puts "Площадь треугольника с основанием #{base} и высотой #{height} составляет #{0.5 * base * height}"
