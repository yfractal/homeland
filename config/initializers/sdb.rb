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
end

Sdb.scan_all_threads(0.001)