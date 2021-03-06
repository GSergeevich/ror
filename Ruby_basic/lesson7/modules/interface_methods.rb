module InterfaceMethods
  INTERFACE_METHODS = [{ meth: 'create_station!', desc: 'Создать станцию' },
                       { meth: 'create_train!', desc: 'Создать поезд' },
                       { meth: 'create_route!', desc: 'Создать маршрут' },
                       { meth: 'route_change!', desc: 'Добавить или удалить станцию из/в маршрут(а)' },
                       { meth: 'route_set!', desc: 'Назначать маршрут поезду' },
                       { meth: 'carriage_ops!', desc: 'Добавить или отцепить вагоны' },
                       { meth: 'train_move!', desc: 'Переместить поезд по маршруту' },
                       { meth: 'station_list', desc: 'Вывести список станций' },
                       { meth: 'station_trains', desc: 'Вывести список поездов на станции' },
                       { meth: 'trains_carriages', desc: 'Вывести список вагонов поезда' },
                       { meth: 'fill_carriage!', desc: 'Заполнить вагон' }].freeze

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
