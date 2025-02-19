require 'sdb'
require 'puma'

GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)

Thread.new do
  sleep 5

  threads = Thread.list

  puts "threads.count: #{threads.count}"
  threads.each do |thread|
    puts "[#{thread.native_thread_id}] #{thread.name}"
  end

  Sdb.scan_puma_threads(0.001)
end
