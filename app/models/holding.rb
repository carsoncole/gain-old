class Holding < ApplicationRecord
  belongs_to :account
  belongs_to :security, optional: true

  default_scope { order(date: :asc) }
end
