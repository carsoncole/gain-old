class SecurityTransaction < Transaction
  belongs_to :security, optional: true
end