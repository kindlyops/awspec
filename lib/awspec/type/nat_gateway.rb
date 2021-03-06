module Awspec::Type
  class NatGateway < Base
    def initialize(id)
      super
      @resource_via_client = find_nat_gateway(id)
      @id = @resource_via_client[:nat_gateway_id] if @resource_via_client
    end

    STATES = %w(
      pending failed available deleting deleted
    )

    STATES.each do |state|
      define_method state.tr('-', '_') + '?' do
        @resource_via_client[:state] == state
      end
    end

    def has_eip?(ip_address = nil)
      @resource_via_client.nat_gateway_addresses.find do |address|
        return address.public_ip == ip_address
      end
    end
  end
end
