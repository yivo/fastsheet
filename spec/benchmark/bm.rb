require 'benchmark'

require 'rubygems'
require 'bundler/setup'

require_relative 'bm/utils'
require_relative 'bm/draw'
require_relative 'bm/benchmark'

module BM
  # requires gem which is not in Gemfile
  def use_gem(gem)
    Bundler.require(gem)
  end

  def run!(name, n)
    Draw.loading(name, 'Running benchmark')
    bm = Benchmark.measure do
      n.times do |i|
        Draw.total_runs(n)
        Draw.current_run(i + 1)
        yield
      end
    end
    Draw.stop_loading

    Draw.row(name, bm.utime, bm.stime, bm.total, bm.real)
  end

  module_function :use_gem
  module_function :run!
end
