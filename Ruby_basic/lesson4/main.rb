require_relative 'cargocarriage'
require_relative 'cargotrain'
require_relative 'passcarriage'
require_relative 'passtrain'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'interface'

# Seed
stations = {}
routes = {}
trains = {}

stations['st1'] = Station.new('st1')
stations['st3'] = Station.new('st3')
stations['st5'] = Station.new('st5')
routes['r1'] = Route.new(stations['st1'], stations['st5'])
trains['1'] = PassTrain.new('1')
trains['2'] = CargoTrain.new('2')
#

Interface.new(stations,routes,trains)
