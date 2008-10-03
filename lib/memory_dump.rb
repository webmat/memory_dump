require 'ruby-debug'
require 'pp'

module MemoryDump
  NESTED_INFO = {
    :local_variables    => nil,
    :instance_variables => nil,
    :global_variables   => nil,
    :class_variables    => 'self.class.class_variables',
    :constants          => 'Module.constants'
  }
  NESTED_INFO.each_pair{|k,v| NESTED_INFO[k] = k.to_s unless v}
  
  FLAT_INFO = {
    :class              => 'self.class'
  }
  FLAT_INFO.each_pair{|k,v| NESTED_INFO[k] = k.to_s unless v}
  
  NOISY = [:global_variables, :constants]
  
  # Just call 'dump'
  def dump(b=binding)
    debugger
    info = NESTED_INFO.reject{|k,v| NOISY.include? k}.inject({}) { |memo, pair|
      what, how = *pair
      memo[what] = fetch_nested how, b
      memo
    }.merge(FLAT_INFO.inject({}) { |memo, pair|
      what, how = *pair
      memo[what] = fetch_flat how, b
      memo
    }) # <= Hey, like Javascript!
    pp info
  end
  
  def fetch_flat(what, b)
    eval what, b
  end
  
  def fetch_nested(what, b)
    (eval what, b).inject({}) {|memo, var| memo[var] = eval var, b; memo}
  end
end
