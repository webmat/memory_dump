require File.join( File.dirname(__FILE__), 'test_helper')

class DumpTest < Test::Unit::TestCase
                        #to avoid clashes
  attr_accessor :dummy, :dmp
  
  context "with a dummy class instance" do
    setup do
      @dummy = Dummy.new
    end
    
    context "calling dump in an instance method" do
      setup { @dmp = dummy.call_dump }
      
      should "detect it's an instance of the Dummy class" do
        assert_equal Dummy, dmp[:class]
      end
    end
  end
end
