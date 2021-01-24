# frozen_string_literal: true

require './modules/accessors'
require './modules/instance_counter'
require './modules/validation'
require './modules/errors'
require './modules/vendor'
require './modules/interface_methods'

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
      @meth.each_with_index { |meth, index| puts "#{index + 1}\) #{meth[:desc]}" }
      input = gets.chomp
      case input
      when '0'
        break
      else
        @meth[input.to_i - 1] ? send(@meth[input.to_i - 1][:meth]) : raise(InstanceTypeError)
      end

    rescue TitleEmptyError => e
      puts e
      retry
    rescue TitleFormatError => e
      puts e
      puts
      retry
    rescue TitleTypeError => e
      puts e
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
