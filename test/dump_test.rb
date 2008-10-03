require File.join( File.dirname(__FILE__), 'test_helper')

class DumpTest < Test::Unit::TestCase
                        #to avoid clashes
  attr_accessor :dummy, :dmp
  
  def self.should_include_variable_matching(var_name, match)
    key = (var_name.gsub(/@|\$/, '') + 's').to_sym
    
    should "detect the variable #{var_name}" do
      assert dmp[key].keys.include?(var_name)
    end
    
    should "contain the correct value for #{var_name}" do
      assert_match(match, dmp[key][var_name])
    end
  end
  
  def self.should_do_the_basic_detections
    should "detect it's an instance of the Dummy class" do
      assert_equal Dummy, dmp[:class]
    end
    
    should "detect the Dummy class' ancestors" do
      assert dmp[:ancestors].include?(Dummy)
      assert dmp[:ancestors].include?(Object)
    end
    
    should_include_variable_matching('local_variable', /local.*instance/)
    should_include_variable_matching('@instance_variable', /instance\svalue/)
    should_include_variable_matching('@@class_variable', /class\svalue/)
    
    should 'capture a backtrace that includes dummy.rb' do
      assert dmp[:backtrace].detect{|line| 
        %r{#{Regexp.escape('test/helpers/dummy.rb')}} =~ line}
    end
  end
  
  context "with a dummy class instance" do
    setup do
      @dummy = Dummy.new
    end
    
    context "calling a non verbose dump in an instance method" do
      setup { @dmp = dummy.call_dump }
      
      should_do_the_basic_detections
      
      should "not include the global variables" do
        assert_nil dmp[:global_variables]
      end
      
      should "not include the constants" do
        assert_nil dmp[:constants]
      end
    end
    
    context "calling the verbose dump in an instance method" do
      setup { @dmp = dummy.call_verbose_dump }
      
      should_do_the_basic_detections
      
      should "include the global variables" do
        assert dmp[:global_variables]
      end
      
      should "include the constants" do
        assert dmp[:constants]
      end
    end
  end
  
end
