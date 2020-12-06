class MyClass
  include NS

  def initialize(name)
    @name = name
  end
end

class Polygon
  class << self 
    attr_accessor :sides
  end
  @sides = 8
end
