require 'benchmark/ips'

STRANG = "mystrang"
# BIG_HASH = {"foo" => "bar", "hello" => "world", "sup" => "yo", "hi" => "there", "how" => "are", "you" => "doing"}
SMALL_HASH = {"foo" => "bar"}

require 'memory_profiler'

report = MemoryProfiler.report do
  SMALL_HASH.dup
  # BIG_HASH.dup
  STRANG.dup
end
report.pretty_print

val = (1..Float::INFINITY).each.detect { |v|
  ((232 * v) % 40 == 0)
}

# 288  big_o/hash_verus_string.rb:11 # 288 * 10 # => 2880
# 192  big_o/hash_verus_string.rb:10 # 192 * 15 # => 2880
#  40  big_o/hash_verus_string.rb:12 # 40 * 72  # => 2880

# 192  big_o/hash_verus_string.rb:9 # => 192 * 5 # => 960
#  40  big_o/hash_verus_string.rb:10 # 40 * 24 #=> 960

GC.disable
Benchmark.ips do |x|
  # x.report("big hash dup ") { 10.times.each { BIG_HASH.dup   } }
  x.report("lil hash dup ") { 5.times.each { SMALL_HASH.dup } }
  x.report("strang dup   ") { 29.times.each { SMALL_HASH.dup } }

  x.compare!
end

# $ ruby big_o/hash_verus_string.rb
# Warming up --------------------------------------
#            hash dup     19.987k i/100ms
#           string dup    19.162k i/100ms
# Calculating -------------------------------------
#            hash dup     205.122k (± 4.7%) i/s -      1.039M in   5.078959s
#           string dup    197.130k (± 4.5%) i/s -    996.424k in   5.066587s

# Comparison:
#            hash dup :   205122.2 i/s
#           string dup:   197130.4 i/s - same-ish: difference falls within error