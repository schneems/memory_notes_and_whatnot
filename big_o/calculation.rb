require 'benchmark/ips'


def compare_max(a, b)
  return a if a > b
  b
end

def allocate_max(a, b)
  array = [a, b]
  array.max
end

Benchmark.ips do |x|
  x.report("allocate_max") {
    100.times.each do
      allocate_max(1, 2)
    end
  }
  x.report("compare_max ") {
    200.times.each do
      compare_max(1, 2)
    end
  }
  x.compare!
end
