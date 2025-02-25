require 'sdb'
require 'puma'

GC.auto_compact = true
Sdb::PumaPatch.patch(Rails.logger)

module PumaThreadRegistration
  def set_thread_name(name)
    if name.include?('srv tp')
      puts "Registering thread #{name}"
      SdbSignal.register_current_thread
    end

    super(name)
  end
end

module Puma
  class << self
    prepend PumaThreadRegistration
  end
end

SdbSignal.setup_signal_handler
SdbSignal.start_scheduler

# SdbSignal.set_sampling_interval(100_000)
# SdbSignal.set_sampling_interval(10_000)
# SdbSignal.set_sampling_interval(1_000)
