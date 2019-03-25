require 'benchmark/ips'

class Foo
  attr_accessor :value
end

require 'memory_profiler'
STRANG = "mystrang"

report = MemoryProfiler.report do
  Foo.new
  STRANG.dup
end
report.pretty_print

FFFFFFFF = Foo.new
FFFFFFFF.value = STRANG.dup

Benchmark.ips do |x|
  x.report("Foo new ") { FFFFFFFF.clone }
  x.report("string clone") { STRANG.clone }
  x.compare!
end