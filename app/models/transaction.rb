class Transaction < ApplicationRecord  
  belongs_to :account
  belongs_to :security

  validates :date, presence: true

  attr_accessor :avoid_recalc

  default_scope { order(date: :asc, created_at: :asc) }

  # before_save :update_holdings!


  private

  # def update_holdings!
  #   existing_holding = account.holdings.where(date: date, security_id: security_id).first

  #   if existing_holding
  #     existing_holding.quantity += (quantity || 0) - (quantity_was || 0)
  #     existing_holding.save
  #   else
  #     account.holdings.create(date: date, security_id: security_id, quantity: quantity)
  #   end
  # end
end
