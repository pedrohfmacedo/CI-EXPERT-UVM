#!/usr/bin/tclsh
puts "Hello world" ; #multiple args are not allowed
puts -nonewline "Hello world"
puts "!!!"
# Scalars
set a 5
puts $a
set str "hello five"
puts $str
set "name surname" "Pedro Macedo"
puts ${name surname}
# Variable Ref
upvar 0 a b;
puts $b
