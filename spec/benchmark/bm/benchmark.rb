module BM
  class Benchmark
    def initialize(name: nil, runs: 1)
      @name = name
      @runs = runs
    end

    # requires gem which is not in Gemfile
    def use_gem(gem)
      # require ''
      Bundler.require(gem)
    end

    def run!(name, n)
      loading(name, 'Running benchmark')

      bm = Benchmark.measure do
        0.upto(@times) do |i|
          yield
        end
      end

      stop_loading

      draw_row(name, bm.utime, bm.stime, bm.total, bm.real)
    end
  end
end
