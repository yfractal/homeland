require 'sdb'
require 'puma'

GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)

SdbSignal.setup_signal_handler

Thread.new do
  sleep 5 # wait for puma threads start
  threads = Thread.list.select { |thread| thread != Thread.current }
  SdbSignal.start_scheduler(threads)
  puts "SdbSignal scheduler started to scan threads=#{threads}"
end
