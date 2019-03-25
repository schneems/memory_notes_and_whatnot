def my_concat(a, b)
  return a + b # <====================
end

require 'fileutils'
require 'objspace'
FileUtils.mkdir_p("tmp")

def run
  ObjectSpace.trace_object_allocations do
    10.times do
      my_concat("hello".freeze, "world".freeze)
    end

    10.times do
      my_concat("hello".freeze, "world".freeze)
    end
  end

  ObjectSpace.each_object do |obj|
    file = ObjectSpace.allocation_sourcefile(obj)
    line = ObjectSpace.allocation_sourceline(obj)
    next unless file && line
    puts "#{file}:#{line}"
  end
end

run
