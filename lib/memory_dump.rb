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
    :class              => 'self.class',
    :ancestors          => 'self.class.ancestors',
    :backtrace          => 'caller'
  }
  
  NOISY = [:global_variables, :constants]
  
  # You can call dump in one of two ways
  #   dump binding
  # or
  #   dump {}
  def self.dump(b, options)
    nested = options[:verbose] ? NESTED_INFO : NESTED_INFO.reject{|k,v| NOISY.include? k}
    
    info_nested  = nested.inject({}) { |memo, pair|
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
  
  protected
  
  def self.fetch_flat(how, b)
    eval how, b
  end
  
  def self.fetch_nested(how, b)
    (eval how, b).inject({}) {|memo, var| memo[var] = eval var, b; memo}
  end
end

def dump(*args, &block)
  b=args.detect{|a| a.is_a? Binding}
  
  case
  when block_given?
    b=block.binding
  when b.is_a?(Binding)
  else
    raise ArgumentError, "Either pass 'binding' as the only argument to dump or pass an empty block"
  end
  
  (options = {})[:verbose] = !(args & [:v, :verbose]).empty?
  MemoryDump.dump(b, options)
end
