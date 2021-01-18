# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end
end

module Accessors

  def attr_accessor_with_history(*attrs)
    attrs.each do |attr| 
    #getter
      self.class.define_method(attr.to_sym) do 
        instance_variable_get("@#{attr}")
      end

    #getter
      self.class.define_method("#{attr}_history".to_sym) do 
        instance_variable_get("@#{attr}_history")
      end

    #setter
      self.class.define_method("#{attr}=".to_sym) do |value|
        instance_variable_set("@#{attr}".to_sym, value)
        if instance_variable_get("@#{attr}_history")
          instance_variable_get("@#{attr}_history").push(value)
        else
          instance_variable_set("@#{attr}_history", [value]) 
        end
      end
    end

  def strong_attr_accessor(attr_name,attr_class)
    @attr_name = attr_name.to_s
    @attr_class = attr_class.to_s
    #getter
    self.class.define_method(@attr_name.to_sym) do 
      instance_variable_get("@#{@attr_name}")
    end
    #setter
    self.class.define_method("#{@attr_name}=".to_sym) do |value|
      value.class.to_s == "#{@attr_class}" ? instance_variable_set("@#{@attr_name}".to_sym, value) : raise("Несоответствие типа переменной")
    end
  end
end
end

module Validation

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods

    def validate(entity,validation,*arg)
      case validation
        when :presence
          name = entity.to_s
          !(name.nil? || name == '')
        when :format
          name = entity.to_s
          p name =~ arg[0]
        when :type
          entity.class.to_s == arg[0].to_s
      end
    end 
  end

  module InstanceMethods
    def validate!(name:,regexp:,class_name:,object:)
      self.class.validate(name,:presence) ? true : raise("Валидация 'presence' не пройдена")
      self.class.validate(name,:format,regexp) ? true : raise("Валидация 'format' не пройдена")
      self.class.validate(object,:type,class_name) ? true : raise("Валидация 'type' не пройдена")
    end

  end

end



module InterfaceMethods
  INTERFACE_METHODS = { 1 => { meth: 'create_station!', desc: 'Создать станцию' },
                        2 => { meth: 'create_train!', desc: 'Создать поезд' },
                        3 => { meth: 'create_route!', desc: 'Создать маршрут' },
                        4 => { meth: 'route_change!', desc: 'Добавить или удалить станцию из/в маршрут(а)' },
                        5 => { meth: 'route_set!', desc: 'Назначать маршрут поезду' },
                        6 => { meth: 'carriage_ops!', desc: 'Добавить или отцепить вагоны' },
                        7 => { meth: 'train_move!', desc: 'Переместить поезд по маршруту' },
                        8 => { meth: 'station_list', desc: 'Вывести список станций' },
                        9 => { meth: 'station_trains', desc: 'Вывести список поездов на станции' },
                        10 => { meth: 'trains_carriages', desc: 'Вывести список вагонов поезда' },
                        11 => { meth: 'fill_carriage!', desc: 'Заполнить вагон' } }.freeze

  private

  def create_station!
    puts 'Введите название станции:'
    title = gets.chomp
    puts "Станция #{Station.new(title).title} создана."
  end

  def create_train!
    puts 'Введите номер поезда:'
    number = gets.chomp
    puts <<~INPUT
      Введите тип поезда:
      1)пассажирский
      2)грузовой
    INPUT
    type = gets.chomp
    case type
    when '1'
      puts "Поезд #{PassTrain.new(number).number} создан."
    when '2'
      puts "Поезд #{CargoTrain.new(number).number} создан."
    else
      raise InstanceTypeError
    end
  end

  def create_route!
    puts 'Введите название маршрута:'
    title = gets.chomp
    puts 'Введите начальную станцию маршрута:'
    raise InstanceNotExistError unless (first = Station.all[gets.chomp])

    puts 'Введите конечную станцию маршрута:'
    raise InstanceNotExistError unless (last = Station.all[gets.chomp])

    Route.new(title, first, last)
    puts "Маршрут #{title} создан."
  end

  def route_change!
    puts 'Введите название станции для операции с маршрутом:'
    raise InstanceNotExistError unless (station = Station.all[gets.chomp])

    puts 'Введите название маршрута:'
    raise InstanceNotExistError unless (route = Route.all[gets.chomp])

    if route.stations.include? station
      puts route.delete(station) ? "#{station.title} удалена из маршрута" : "#{station.title} терминальная,удаление невозможно"
    else
      puts route.insert(station) ? "#{station.title} добавлена в маршрут" : 'Что-то пошло не так.Убедитесь в корректности ввода'
    end
  end

  def route_set!
    puts 'Введите номер поезда:'
    raise InstanceNotExistError unless (train = Train.all[gets.chomp.to_s])

    puts 'Введите название маршрута:'
    raise InstanceNotExistError unless (route = Route.all[gets.chomp])

    puts "Поезду #{train.number} присвоен маршрут: #{train.route!(route)}"
  end

  def carriage_ops!
    puts 'Введите номер поезда'
    raise InstanceNotExistError unless (train = Train.all[gets.chomp.to_s])

    puts <<~INPUT
      Выберите действие:
      1)Прицепить вагон
      2)Отцепить вагон
    INPUT
    input = gets.chomp
    case input
    when '1'
      puts <<~INPUT
        Введите тип вагона:
        1)пассажирский
        2)грузовой
      INPUT
      input = gets.chomp
      case input
      when '1'
        puts 'Введите количество мест в вагоне:'
        seats = gets.chomp.to_i
        puts train.attach(PassCarriage.new(seats)) ? 'Вагон прицеплен' : 'Операция не выполнена.Проверьте корректность ввода'
      when '2'
        puts 'Введите грузовой объём вагона:'
        capacity = gets.chomp.to_i
        puts train.attach(CargoCarriage.new(capacity)) ? 'Вагон прицеплен' : 'Операция не выполнена.Проверьте корректность ввода'
      else
        raise InstanceTypeError
      end
    when '2'
      puts train.detach ? 'Вагон отцеплен' : 'Операция не выполнена.Проверьте корректность ввода'
    else
      raise InstanceTypeError
    end
  end

  def train_move!
    puts 'Введите номер поезда'
    raise InstanceNotExistError unless (train = Train.all[gets.chomp.to_s])

    puts <<~INPUT
      Выберите направление движения:
      1)Вперед по маршруту
      2)Назад по маршруту
    INPUT
    input = gets.chomp
    case input
    when '1'
      puts train.route ? "Станция #{train.forward}" : 'Поезду не назначен маршрут'
    when '2'
      puts train.route ? "Станция #{train.backward}" : 'Поезду не назначен маршрут'
    else
      raise InstanceTypeError
    end
  end

  def station_list
    puts(Station.all.keys.tap { |output| puts 'Станций не найдено' if output == [] })
  end

  def station_trains
    puts 'Введите название станции:'
    raise InstanceNotExistError unless (station = Station.all[gets.chomp])

    station.trains { |train| puts "Поезд номер #{train.number}" }
  end

  def trains_carriages
    puts 'Введите номер поезда:'
    raise InstanceNotExistError unless (train = Train.all[gets.chomp])

    train.allcarriages { |carriage| puts " #{carriage} : #{carriage.occupied} occupied, #{carriage.free?} free." }
  end

  def fill_carriage!
    puts 'Введите номер поезда:'
    raise InstanceNotExistError unless (train = Train.all[gets.chomp])

    puts 'Введите номер вагона:'
    raise InstanceNotExistError unless (carriage = train.carriages[(gets.chomp.to_i - 1)])

    if carriage.type == 'cargo'
      puts 'Введите занимаемый объём:'
      quantity = gets.chomp.to_i
      puts carriage.occupy!(quantity) ? "Выполнено.В вагоне остаётся #{carriage.free?} свободного объёма." : "Не выполнено.В вагоне #{carriage.free?} свободного объёма."
    else
      puts carriage.occupy! ? "Выполнено.В вагоне свободно #{carriage.free?} мест(а)." : "Не выполнено.В вагоне свободно #{carriage.free?} мест."
    end
  end
end

module Vendor
  attr_accessor :vendor
end

class InstanceTypeError < RuntimeError
end

class TrainTitleError < RuntimeError
end

class TitleError < RuntimeError
end

class InstanceExistError < RuntimeError
end

class InstanceNotExistError < RuntimeError
end
