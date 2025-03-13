require 'sdb'
require 'puma'

GC.auto_compact = true

Sdb::PumaPatch.patch(Rails.logger)

module PumaPatch
  def self.patch
    Puma::Server.class_eval do
      alias_method :old_handle_servers, :handle_servers

      def handle_servers
        # sampling interval 1ms, no allocation tracking
        Vernier.trace(out: "rails.json", hooks: [:rails], interval: 1000, allocation_interval: 0) do |collector|
          old_handle_servers
        end
      end
    end
  end
end

PumaPatch.patch
