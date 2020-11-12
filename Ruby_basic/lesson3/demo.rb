# /usr/bin/env ruby

require_relative 'station'
require_relative 'route'
require_relative 'train'
require 'pry'

station1 = Station.new('Lud')
station2 = Station.new('Candleton')
station3 = Station.new('Rilea')
station4 = Station.new('Dasherville')
station5 = Station.new('Topeka')

r1 = Route.new(station1, station5)

puts 'Добавляем/удаляем станции в маршрут'

r1.stations.each { |st| puts st.title }
r1.insert(station2)
puts '+++'
r1.stations.each { |st| puts st.title }
r1.insert(station3)
puts '+++'
r1.stations.each { |st| puts st.title }
r1.insert(station4)
puts '+++'
r1.stations.each { |st| puts st.title }
r1.delete(station4)
puts '---'
r1.stations.each { |st| puts st.title }
r1.insert(station4)
puts '+++'
r1.stations.each { |st| puts st.title }
puts '---'

puts 'Определяем поезд:'
blaine_the_mono = Train.new(1, 'passengers', 4)
p blaine_the_mono.number

puts '---'
puts "Принимаем маршрут: #{blaine_the_mono.route(r1)}"

puts "Поехали на предыдущую станцию: #{blaine_the_mono.backward}"
puts '---'

puts 'Станции:'
puts <<~EOM
     предыдущая: #{blaine_the_mono.prev_station ? blaine_the_mono.prev_station.title : '-' },
     текущая: #{blaine_the_mono.current_station ? blaine_the_mono.current_station.title : '-' },
     следующая: #{blaine_the_mono.next_station.title ? blaine_the_mono.next_station.title : '-' }.
EOM
puts '---'
puts '---'
puts 'Играем с вагонами:'

puts "Вагонов: #{blaine_the_mono.carriages}"
puts "Прицепили вагон: #{blaine_the_mono.attach}"
puts "Вагонов: #{blaine_the_mono.carriages}"
puts "Отцепили вагон: #{blaine_the_mono.detach}"
puts "Вагонов: #{blaine_the_mono.carriages}"

puts '---'
puts 'Поехали:'

puts "Скорость: #{blaine_the_mono.speed} => #{blaine_the_mono.speed = 1225}"

puts '---'

puts 'Играем с вагонами на скорости'
puts "Вагонов: #{blaine_the_mono.carriages}"
puts "Прицепили вагон: #{blaine_the_mono.attach}"
puts "Вагонов: #{blaine_the_mono.carriages}"
puts "Отцепили вагон: #{blaine_the_mono.detach}"
puts "Вагонов: #{blaine_the_mono.carriages}"

puts "Поехали на следующую станцию: #{blaine_the_mono.forward}"
puts '---'
puts 'Станции:'
puts <<~EOM
     предыдущая: #{blaine_the_mono.prev_station ? blaine_the_mono.prev_station.title : '-' },
     текущая: #{blaine_the_mono.current_station ? blaine_the_mono.current_station.title : '-' },
     следующая: #{blaine_the_mono.next_station.title ? blaine_the_mono.next_station.title : '-' }.
EOM
puts '---'
puts "Поехали на следующую станцию: #{blaine_the_mono.forward}"
puts '-----'
puts "Поехали на следующую станцию: #{blaine_the_mono.forward}"
puts '-----'
puts "На станции #{blaine_the_mono.current_station.title} :"
puts "#{blaine_the_mono.current_station.trains_number}"

puts 'Сброс скорости'
puts "#{blaine_the_mono.speed} => #{blaine_the_mono.speed = 0}"
puts '-----'

puts 'Набор скорости'
puts "#{blaine_the_mono.speed} => #{blaine_the_mono.speed = 1225}"
puts '-----'

puts "Поехали на следующую станцию: #{blaine_the_mono.forward}"
puts '-----'

puts 'Набор скорости'
puts "#{blaine_the_mono.speed = 1500} => #{blaine_the_mono.speed = 1700}"
puts 'Сброс скорости'

puts "#{blaine_the_mono.speed} => #{blaine_the_mono.speed = 0}"

puts "Поехали на следующую станцию: #{blaine_the_mono.forward}"
puts '-----'
puts 'Станции:'
puts <<~EOM
     предыдущая: #{blaine_the_mono.prev_station ? blaine_the_mono.prev_station.title : '-' },
     текущая: #{blaine_the_mono.current_station ? blaine_the_mono.current_station.title : '-' },
     следующая: #{blaine_the_mono.next_station ? blaine_the_mono.next_station.title : '-' }.
EOM
puts '---'

puts 'Приехали'
