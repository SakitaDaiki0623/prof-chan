class AddressBlockSerializer < ActiveModel::Serializer
  attributes :id, :instagram, :full_address, :postcode, :twitter

  belongs_to :profile_block
end
