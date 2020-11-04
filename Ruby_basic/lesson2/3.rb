#!/usr/bin/env ruby

fib = [0,1]

loop do 
  i = fib[-1] + fib[-2]  
  break if i >= 100
  fib << i
end 

p fib
