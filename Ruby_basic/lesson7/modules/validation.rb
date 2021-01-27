module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(entity, check, *arg)
      @validations ||= []
      @validations << { entity: entity, check: check, arguments: arg }
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.validations
      validations.each do |validation|
        send("validate_#{validation[:check]}", eval("@#{validation[:entity]}"), (validation[:arguments][0]))
      end
    end

    def validate_presence(value, *_arg)
      !(value.to_s.nil? || value.to_s == '') || (raise TitleEmptyError, 'Валидация presence не пройдена,название не может быть пустым.')
    end

    def validate_format(value, *arg)
      value.to_s =~ Regexp.new(arg[0]) || (raise TitleFormatError, "Валидация format не пройдена,некорректный формат.Для станции: #{Station::TITLE_FORMAT} ,для поезда: #{Train::NUMBER_FORMAT}, для маршрута: #{Route::TITLE_FORMAT}")
    end

    def validate_type(value, *arg)
      value.class.to_s == arg[0].to_s || (raise TitleTypeError, "Валидация type не пройдена,введён #{value.class},требуется #{arg[0]}")
    end

    def valid?
      validate!
      true
    rescue TitleEmptyError, TitleTypeError, TitleFormatError
      false
    end
  end
end
