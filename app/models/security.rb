class Security < ApplicationRecord
  belongs_to :issuer

  def price_unit
    1
  end

  def par_value
    1
  end
end
