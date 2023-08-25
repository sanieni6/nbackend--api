class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :jwt_authenticatable,
          jwt_revocation_strategy: JwtDenylist

  validates :email, presence: true, length: { minimum: 3, maximum: 50 },
                        format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 3, maximum: 50 }
end
