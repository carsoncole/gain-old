class Issuer < ApplicationRecord
  belongs_to :account
  has_many :securities

  validates :name, presence: true
end
