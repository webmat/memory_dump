require 'rubygems'
require 'test/unit'

test_dir = File.dirname(__FILE__)

# Install the non-Rails shoulda gem with 'gem install Shoulda'
# Notice the capitalization in the name.
require 'shoulda'
require 'mocha'

# Just load redgreen if not running tests from TextMate
IN_TM = !ENV['TM_DIRECTORY'].nil? unless defined?(IN_TM)
require 'redgreen' unless IN_TM

require 'ruby-debug'

require File.join( [test_dir] + %w{ .. lib memory_dump } )

#Keep after the req to memory_dump
Dir[test_dir+'/helpers/**/*.rb'].each{|f| require f} 
