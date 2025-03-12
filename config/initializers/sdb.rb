require 'sdb'
require 'puma'

puts 'Enable auto compact'
GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)
Sdb.scan_puma_threads(0.001)