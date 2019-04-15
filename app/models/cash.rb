class Cash < Security
  validates :account, uniqueness: { scope: :currency }
end