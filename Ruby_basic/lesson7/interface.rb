# frozen_string_literal: true

require_relative 'modules'

class Interface

  include InterfaceMethods 

  def initialize
    @meth = INTERFACE_METHODS
    puts 'Программа управления железной дорогой.'
    run
  end

  def run
    loop do
      puts 'Выберите действие(введите номер),или 0 для выхода:'
      @meth.each { |number, meth| puts "#{number}\) #{meth[:desc]}" }
      input = gets.chomp
      case input
      when '0'
        break
      else
        @meth[input.to_i] ? send(@meth[input.to_i][:meth]) : raise(InstanceTypeError)
      end

      rescue TrainTitleError
        puts 'Некорректный номер поезда,используйте формат: 3 цифры или буквы,опциональный дефис,2 буквы или цифры'
        retry
      rescue StationTitleError
        puts 'Название станции некорректное,используйте не менее одной буквы или цифры'
        retry
      rescue RouteTitleError
        puts 'Название  маршрута некорректное,используйте не менее одной буквы или цифры'
        retry
      rescue InstanceExistError
        puts 'Объект уже существует'
        retry
      rescue InstanceNotExistError
        puts 'Объекта не существует'
        retry
      rescue InstanceTypeError
        puts 'Некорректный ввод, используйте цифры из предложенных вариантов'
        retry 
    end
  end

end
