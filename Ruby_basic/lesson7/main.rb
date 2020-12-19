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
PassTrain.new(12345)
PassTrain.new(23456)
PassTrain.new(34567)
CargoTrain.new(45678)
CargoTrain.new(56789)
CargoTrain.new(67900)
Train.new(11123)
Train.find(12345).vendor = 'Cisco'
# For checking
binding.pry

Interface.new
