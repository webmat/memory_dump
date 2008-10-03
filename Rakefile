require 'rubygems'

require 'rake'

HERE = File.dirname(__FILE__)
windows = (RUBY_PLATFORM =~ /win32|cygwin/) rescue nil
SUDO = windows ? "" : "sudo"

require "#{HERE}/lib/memory_dump"
Dir['tasks/**/*.rake'].each { |rake| load rake }

task :default => :test
