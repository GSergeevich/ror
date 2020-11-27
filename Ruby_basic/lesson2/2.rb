#!/usr/bin/env ruby
arr = (10..100).each_with_object([]) { |number, temp| temp << number if (number % 5).zero? }
p arr

# или

arr = []

(10..100).each do |number|
  arr << number if (number % 5).zero?
end

p arr

# или
arr = []

arr = (10..100).select { |number| (number % 5).zero? }
p arr
