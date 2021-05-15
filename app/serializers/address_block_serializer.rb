class AddressBlockSerializer < ApplicationSerializer
  attributes :id, :instagram, :full_address, :postcode, :twitter

  belongs_to :profile_block
end
