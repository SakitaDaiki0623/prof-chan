module PublicUidGenerator

  def self.included(uuid)
    uuid.before_create :generate_public_uid
  end

  def generate_public_uid
    self.public_uid = loop do
      uuid = SecureRandom.hex(5)
      break uuid unless self.class.exists?(public_uid: uuid)
    end
  end
end
