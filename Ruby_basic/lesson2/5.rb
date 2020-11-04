#!/usr/bin/env ruby

def leap?(year = Time.now.year)
  return false if year % 4 != 0
  year % 100 == 0 ? year % 400 == 0 : true
end

months = [31, :x , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Введите числа: день месяца,месяц и год через запятую:"

d,m,y = *gets.chomp.split(',')

months[1] = leap?(y) ? 28 : 29

print "Порядковый номер #{d} дня #{m} месяца в году : "
puts months[0...(m.to_i - 1)].reduce {|x,m| x + m } + d.to_i

