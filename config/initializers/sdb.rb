require 'sdb'
require 'puma'

puts 'Enable auto compact'
GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)

Thread.new do
  sleep 5

  threads = Thread.list

  puts "threads.count: #{threads.count}"
  puma_threads = []
  threads.each do |thread|
    if thread.name&.include?('puma srv tp')
      puma_threads << thread
      puts "[#{thread.native_thread_id}] #{thread.name}"
    end
    #puts "[#{thread.native_thread_id}] #{thread.name}"
  end

  Sdb.scan_threads(puma_threads, 0.001)
end

Thread.new {
  loop {
    sleep 5
    puts "[GC-compactor] start compact"
    GC.compact
    puts "[GC-compactor] end compact"
  }
}
