require 'sdb'
require 'puma'

GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)
