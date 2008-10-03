require 'ruby-debug'
require 'pp'

module MemoryDump
  # Nested stuff gets eval'ed twice.
  # We find out what the names are (e.g. variable name) and then find out their value.
  NESTED_INFO = {
    # what gets fetched => how it gets fetched
    :local_variables    => 'local_variables',
    :instance_variables => 'instance_variables',
    :global_variables   => 'global_variables',
    :class_variables    => 'self.class.class_variables',
    :constants          => 'Module.constants'
  }
  
  # We go fetch these informations directly.
  FLAT_INFO = {
    :class              => 'self.class.to_s',
    :ancestors          => 'self.class.ancestors',
    :backtrace          => 'caller'
  }
  
  NOISY = [:global_variables, :constants]
  
  # You can call dump in one of two ways
  #   dump binding
  # or
  #   dump {}
  def dump(b=nil, &block)
    case
    when block_given?
      b=block.binding
    when b.is_a?(Binding)
    else
      raise ArgumentError, "Either pass 'binding' as the only argument to dump or pass an empty block"
    end
    
    info_nested  = NESTED_INFO.reject{|k,v| NOISY.include? k}.inject({}) { |memo, pair|
      what, how  = *pair
      memo[what] = fetch_nested how, b
      memo
    }
    info_flat    = FLAT_INFO.inject({}) { |memo, pair|
      what, how  = *pair
      memo[what] = fetch_flat how, b
      memo
    }
    return info_nested.merge(info_flat)
  end
  
  def fetch_flat(how, b)
    eval how, b
  end
  
  def fetch_nested(how, b)
    (eval how, b).inject({}) {|memo, var| memo[var] = eval var, b; memo}
  end
end
