class Security < ApplicationRecord
  belongs_to :issuer, optional: true

  validates :issuer, uniqueness: { scope: :currency }, if: Proc.new { |s| s.is_cash? }

  def par_value
    1
  end
end
