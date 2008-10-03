class Dummy
  DUMMY_CONST = 'dummy const value'
  
  @@class_variable = 'dummy class value'
  
  attr_accessor :instance_variable
  
  def initialize
    @instance_variable = 'dummy instance value'
  end
  
  def call_dump
    local_variable = 'local variable in instance method'
    dump{}
  end
  
  def call_verbose_dump
    local_variable = 'local variable in instance method'
    dump(:v){}
  end
  
  def self.call_dump
    local_variable = 'local variable in class method'
    dump{}
  end
  
  def self.call_verbose_dump
    local_variable = 'local variable in class method'
    dump(:v){}
  end
end
