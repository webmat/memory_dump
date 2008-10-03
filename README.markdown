What?
===

By using Ruby's Bindings, I can tell you a lot of stuff :-)


Usage
===

    dump{}

Will give you a nested Hash containing most variables accessible from where you called it, 
as well as a few other interesting tidbits:

    {:instance_variables=>{"@instance_variable"=>"instance var's value"},
     :class=>YourClass,
     :local_variables=>{"local"=>"local var's value"},
     :class_variables=>{"@@class_variable"=>"class var's value"},
     :ancestors=>[YourClass, YourMom, Object],
     :backtrace=>['you_get_the_drift.rb']}

If you're ready for an explosion of (very interesting) information, call it in verbose mode:

    dump(:verbose){}
    dump(:v){}

You'll get an additional hash of all the global variables and their values, as well as an
array of all constants accessible from that binding.

Other stuff
===

To know more about bindings, check out
* [Variable Bindings in Ruby](http://onestepback.org/index.cgi/Tech/Ruby/RubyBindings.rdoc)


