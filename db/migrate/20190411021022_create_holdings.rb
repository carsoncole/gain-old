class CreateHoldings < ActiveRecord::Migration[5.2]
  def change
    create_table :holdings do |t|
      t.references :account, foreign_key: true
      t.date :date
      t.references :security, foreign_key: true
      t.decimal :quantity
      t.index [:date, :account_id]

      t.timestamps
    end
  end
end
