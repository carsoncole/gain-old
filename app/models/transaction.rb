class Transaction < ApplicationRecord
  belongs_to :account

  attr_accessor :avoid_recalc

  validates :date, presence: true

  default_scope { order(date: :asc, created_at: :desc) }
end
