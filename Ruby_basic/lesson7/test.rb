require 'pry'
require_relative 'modules'

class My
  include Accessors
  include Validation

  define_method :z do
    "Zzzzzzzzz"
    end
end

my = My.new
p my.methods
puts my.z
p "-------------"
My.define_method(:x) {p "Xxxxxx"}
p my.methods
p my.x

my.attr_accessor_with_history :a , :b , :c
p my.methods
p my.a
my.a = 3
p my.a
my.a = 4
p my.a
my.a = 6
p my.a
p my.a_history

p my.b
my.b = 5
p my.b

my.strong_attr_accessor :v , Array
my.v = [1,2,3]
p my.v

p my.class.validate "asd" , :format , /a*/
my.validate! name: "asd" ,regexp: /a*/ ,class_name: Array , object: []

