# encoding: utf-8

module Cql
  class Builder
    class Settings
      attr_reader   :addresses
      attr_accessor :port, :protocol_version, :connection_timeout,
                    :default_consistency, :logger, :compressor, :credentials,
                    :auth_provider

      def initialize(addresses, port, protocol_version, connection_timeout,
                     default_consistency, logger, compressor, credentials,
                     auth_provider)
        @addresses           = addresses
        @port                = port
        @protocol_version    = protocol_version
        @connection_timeout  = connection_timeout
        @default_consistency = default_consistency
        @logger              = logger
        @compressor          = compressor
        @credentials         = credentials
        @auth_provider       = auth_provider
      end
    end
  end
end
