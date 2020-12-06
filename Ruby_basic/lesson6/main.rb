require_relative 'cargocarriage'
require_relative 'cargotrain'
require_relative 'passcarriage'
require_relative 'passtrain'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'interface'
require 'pry'

# Seed
Station.new('st1')
Station.new('st3')
Station.new('st5')
Route.new('r1', Station.all['st1'], Station.all['st5'])
Route.new('r2', Station.all['st3'], Station.all['st5'])
PassTrain.new(1)
PassTrain.new(2)
PassTrain.new(3)
CargoTrain.new(4)
CargoTrain.new(5)
CargoTrain.new(6)
Train.new(111)
Train.find(2).vendor = 'Cisco'
#For checking
binding.pry

Interface.new
