module Accessors
  def attr_accessor_with_history(*attrs)
    attrs.each do |attr|
      # getter
      self.class.define_method(attr.to_sym) do
        instance_variable_get("@#{attr}")
      end

      # getter
      self.class.define_method("#{attr}_history".to_sym) do
        instance_variable_get("@#{attr}_history")
      end

      # setter
      self.class.define_method("#{attr}=".to_sym) do |value|
        instance_variable_set("@#{attr}".to_sym, value)
        if instance_variable_get("@#{attr}_history")
          instance_variable_get("@#{attr}_history").push(value)
        else
          instance_variable_set("@#{attr}_history", [value])
        end
      end
    end
  end

  def strong_attr_accessor(attr_name, attr_class)
    @attr_name = attr_name.to_s
    @attr_class = attr_class.to_s
    # getter
    self.class.define_method(@attr_name.to_sym) do
      instance_variable_get("@#{@attr_name}")
    end
    # setter
    self.class.define_method("#{@attr_name}=".to_sym) do |value|
      value.class.to_s == @attr_class.to_s ? instance_variable_set("@#{@attr_name}".to_sym, value) : raise('Несоответствие типа переменной')
    end
  end
end
