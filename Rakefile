require_relative 'spec/benchmark/bm'

desc 'Build native extension'
task :build do
  ruby 'extconf.rb'
end

desc 'Run benchmark'
task :benchmark do
  # BM::Draw.title('Running benchmarks of Roo, Creek and Fastsheet gems')
  # BM::Draw.header

  # Allow require system gems
  Bundler.reset!

  require 'roo'
  p Roo

  Object.send(:remove_const, :Roo)
  Bundler.reset!

  require 'creek'
  p Creek

  # run benchmarks
  #
  # we can't run them all from single file because roo and creek
  # use different nokogiri versions
  # system 'spec/benchmark/roo-bm'
  # system 'spec/benchmark/creek-bm'
  # system 'spec/benchmark/fastsheet-bm'
end

# TODO
desc 'Run tests'
task :test do
  puts 'no tests'
end

task default: %i[build test]
