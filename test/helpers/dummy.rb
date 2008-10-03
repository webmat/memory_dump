class Dummy
  DUMMY_CONST = 'dummy const value'
  
  @@class_attribute = 'dummy class value'
  
  attr_accessor :instance_attribute
  
  def initialize
    @instance_attribute = 'dummy instance value'
  end
  
  def call_dump
    var = 'local variable in instance method'
    dump{}
  end
  
  def self.call_dump
    var = 'local variable in class method'
    dump{}
  end
end
