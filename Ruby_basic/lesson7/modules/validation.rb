module Validation

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(entity,check,*arg)
      @validations ||= []
      @validations << {entity: entity,check: check,arguments: arg}
    end

  end

  module InstanceMethods

    def validate!
      validations = self.class.instance_variable_get("@validations")
      validations.each do |validation|
        name = eval("@#{validation[:entity].to_s}")
        case validation[:check]
          when :presence
            !(name.nil? || name == '') || (raise TitleEmptyError.new("Валидация #{validation[:check]} не пройдена"))
          when :format
            name.to_s =~ validation[:arguments][0] || (raise TitleFormatError.new("Валидация #{validation[:check]} не пройдена,"))  
          when :type
             name.class.to_s == validation[:arguments][0].to_s || (raise TitleTypeError.new("Валидация #{validation[:check]} не пройдена")) 
        end
        
      end
    end

    def valid?
      validate!
      true
    rescue TitleEmptyError
      false
    rescue TitleTypeError
      false
    rescue TitleFormatError
      false
    end

  end

end