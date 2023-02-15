class User < ApplicationRecord
  rolify
  has_one :team
  has_paper_trail
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include devise modules.
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  validates :name, presence: true, length: { maximum: 50 }
  validates :level_english, presence: true
  validates :technical_knowledge, presence: true
  validates :resume_url, presence: true
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

end
