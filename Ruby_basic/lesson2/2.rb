#!/usr/bin/env ruby
arr = (10..100).each_with_object([]) {|number,temp| temp << number if number % 5 == 0}
p arr

#или

arr = []

(10..100).each do | number |
  if number % 5 == 0	
	arr << number
  end
end

p arr

#или
arr = []

arr = (10..100).select {|number| number % 5 == 0 }
p arr
