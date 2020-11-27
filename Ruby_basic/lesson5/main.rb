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
Station.new('st1')
Station.new('st3')
Station.new('st5')
Route.new('r1', Station.all['st1'], Station.all['st5'])
PassTrain.new(1)
CargoTrain.new(2)
Train.find(2).vendor = 'Cisco'
#

Interface.new
