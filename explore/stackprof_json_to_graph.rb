require 'json'
require 'logger'

def log(*line)
  logger = Logger.new(STDOUT, level: :info)
  logger.info(line.inspect)
end

def nodes_for(graph, edge)
  log "Finding children for " + edge
  graph.select do |name, node|
    edges = node.fetch("edges", {})
    log edges.key? edge
    edges[edge]
  end.tap { |k| puts "***********" + k.keys.inspect}.map { |name, node|
    node["edges"].count > 0 && node["children"] = nodes_for(graph, name)
    node
  }
rescue => e
  puts edge.inspect
  raise e
end

graph = JSON.parse(DATA.read)["frames"]

file = "/Users/caleb.thompson/code/ctio/talks/memory.rb"
line = 2
requested_line = graph.select do |k,v|
  v["file"] == file
  v["line"] == line - 1
end.each do |k,_|
  nodes_for(graph, k)
end
log __LINE__, requested_line

__END__
{
  "version": 1.2,
  "mode": "object",
  "interval": 1,
  "samples": 20,
  "gc_samples": 0,
  "missed_samples": 0,
  "frames": {
    "70335802928260": {
      "name": "Object#my_concat",
      "file": "/Users/caleb.thompson/code/ctio/talks/memory.rb",
      "line": 1,
      "total_samples": 20,
      "samples": 20,
      "lines": {
        "2": [
          20,
          20
        ]
      }
    },
    "70335798837460": {
      "name": "Object#run",
      "file": "/Users/caleb.thompson/code/ctio/talks/memory.rb",
      "line": 8,
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335802928260": 20,
        "70335798837460": 40,
        "70335798808600": 20
      },
      "lines": {
        "12": [
          10,
          0
        ],
        "11": [
          10,
          0
        ],
        "10": [
          20,
          0
        ],
        "9": [
          20,
          0
        ],
        "16": [
          10,
          0
        ],
        "15": [
          10,
          0
        ]
      }
    },
    "70335798809240": {
      "name": "MemoryProfiler::Reporter#run",
      "file": "/Users/caleb.thompson/code/ctio/talks/.gem/ruby/2.3.7/gems/memory_profiler-0.9.12/lib/memory_profiler/reporter.rb",
      "line": 69,
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335798837460": 20
      },
      "lines": {
        "72": [
          20,
          0
        ]
      }
    },
    "70335798809300": {
      "name": "MemoryProfiler::Reporter.report",
      "file": "/Users/caleb.thompson/code/ctio/talks/.gem/ruby/2.3.7/gems/memory_profiler-0.9.12/lib/memory_profiler/reporter.rb",
      "line": 30,
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335798809240": 20
      },
      "lines": {
        "31": [
          20,
          0
        ]
      }
    },
    "70335798808600": {
      "name": "#<Module:0x00007ff0a90a5e50>.report",
      "file": "/Users/caleb.thompson/code/ctio/talks/.gem/ruby/2.3.7/gems/memory_profiler-0.9.12/lib/memory_profiler.rb",
      "line": 12,
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335798809300": 20
      },
      "lines": {
        "13": [
          20,
          0
        ]
      }
    },
    "70335802929520": {
      "name": "<main>",
      "file": "/Users/caleb.thompson/code/ctio/talks/memory.rb",
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335798837460": 20
      },
      "lines": {
        "24": [
          20,
          0
        ]
      }
    },
    "70335798130520": {
      "name": "<main>",
      "file": "memory.rb",
      "total_samples": 20,
      "samples": 0,
      "edges": {
        "70335802929520": 20
      }
    }
  }
}