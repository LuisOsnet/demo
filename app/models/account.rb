# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :teams, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :client_name, presence: true, length: { maximum: 50 }
  validates :owner, presence: true, length: { maximum: 50 }
end
