class Holding < ApplicationRecord
  belongs_to :account
  belongs_to :security, optional: true
end
