require File.join( File.dirname(__FILE__), 'test_helper')

class ArgumentParsingTest < Test::Unit::TestCase
  
  # Call with parse_arguments_as(binding, {expected args})
  # This can't be put in a setup block, the binding won't be the same
  def expected_options(options)
    MemoryDump.expects(:dump).with{|b, arg_options| options == arg_options }
  end
  
  def self.should_be_gotten_from_arguments(string)
    should "accept #{string}" do
      dump(eval(string)){}
    end
  end
  
  context 'to specify verbosity' do
    setup do
      expected_options(:verbose => true)
    end
    should_be_gotten_from_arguments ':v'
    should_be_gotten_from_arguments ':verbose'
    should_be_gotten_from_arguments '{:verbose => true}'
  end
end
