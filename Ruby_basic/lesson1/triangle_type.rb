#!/usr/bin/env ruby

puts 'Введите три стороны треугольника - a,b,c:'
sides = Array.new(gets.chomp.split(','))
a,b,c = *sides.map!(&:to_f)

print "Треугольник является "

# hyp_pyp mean a "hypotetical hypotenuse"
hyp_hyp = sides.sort![-1]

if hyp_hyp ** 2 == sides[0] ** 2 + sides[1] ** 2
  puts "прямоугольным." 

elsif a == b && b == c 
  puts "равносторонним и равнобедренным."

elsif
  a == b || b == c || a == c
  puts "равнобедренным."

end
