require_relative 'cargocarriage'
require_relative 'cargotrain'
require_relative 'passcarriage'
require_relative 'passtrain'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'interface'
#require_relative 'modules'

# Seed
stations = {}
routes = {}
#trains = {}

stations['st1'] = Station.new('st1')
stations['st3'] = Station.new('st3')
stations['st5'] = Station.new('st5')
routes['r1'] = Route.new(stations['st1'], stations['st5'])
PassTrain.new(1)
CargoTrain.new(2)
Train.find(2).vendor = 'Cisco'
p Station.all

Interface.new(stations, routes)
