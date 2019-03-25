require 'benchmark/ips'

LITTLE_STRING = "mystrang"
BIG_STRING = "mystrangggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg"

require 'memory_profiler'

report = MemoryProfiler.report do
  s = LITTLE_STRING.dup; s[0].upcase
  s = BIG_STRING.dup; s[0].upcase
end
report.pretty_print

# allocated memory by location
# -----------------------------------
#         40  big_o/string_verus_array.rb:10
#         40  big_o/string_verus_array.rb:9

Benchmark.ips do |x|
  x.report("little string dup ") { s = "mystrang".dup; s[0].upcase }
  x.report("bit string dup    ") { s = "mystrangggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg".dup; s[0].upcase }
  x.compare!
end

# $ ruby big_o/string_verus_array.rb
# Warming up --------------------------------------
#           array dup    244.936k i/100ms
#           string dup   229.914k i/100ms
# Calculating -------------------------------------
#           array dup       4.674M (± 5.0%) i/s -     23.514M in   5.045192s
#           string dup      4.411M (± 2.1%) i/s -     22.072M in   5.005630s

# Comparison:
#           array dup :  4674014.6 i/s
#           string dup:  4411360.8 i/s - same-ish: difference falls within error

