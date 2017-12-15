class User < ApplicationRecord

  validates :password, presence: true, length: { minimum: 6 }

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

end
