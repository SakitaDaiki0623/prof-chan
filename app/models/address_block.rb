class AddressBlock < ApplicationRecord
  belongs_to :profile_block

  validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
end
