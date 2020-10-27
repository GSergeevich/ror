#!/usr/bin/env ruby
puts 'Введите три стороны треугольника - a,b,c:'
sides = Array.new(gets.chomp.split(','))
a,b,c = *sides

print "Треугольник является "

if a == b && b == c 
	puts "равносторонним."
elsif
   a == b || b == c
   puts "равнобедренным."
else
   puts "прямоугольным." 
end