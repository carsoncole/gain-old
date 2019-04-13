class Issuer < ApplicationRecord
  validates :name, presence: true
end
