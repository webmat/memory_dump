require 'ruby-debug'
require 'pp'
module MemoryDump
  VARIABLE_TYPES = {
    :local_variables    => nil, 
    :instance_variables => nil, 
    :global_variables   => nil,
    :class_variables    => 'self.class.class_variables',
    :constants          => 'Module.constants'
  }
  VARIABLE_TYPES.each_pair{|k,v| VARIABLE_TYPES[k] = k.to_s unless v}
  
  NOISY = [:global_variables, :constants]
  
  # Just call 'dump'
  def dump(b=binding)
    info = VARIABLE_TYPES.reject{|k,v| NOISY.include? k}.inject({}) do |memo, pair|
      what, how = *pair
      memo[what] = fetch how, b
      memo
    end 
    pp info
  end
  
  def fetch(what, b)
    (eval what, b).inject({}) {|memo, var| memo[var] = eval var, b; memo}
  end
end
