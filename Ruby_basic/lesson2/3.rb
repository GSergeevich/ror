#!/usr/bin/env ruby

fib = [0, 1]

while (i = fib[-1] + fib[-2]) <= 100
  fib << i
end

p fib
