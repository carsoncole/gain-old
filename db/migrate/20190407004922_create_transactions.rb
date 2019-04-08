class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.date :date
      t.references :account, foreign_key: true
      t.references :security, foreign_key: true
      t.decimal :price, scale: 5, precision: 15
      t.decimal :quantity, scale: 2, precision: 12
      t.decimal :accrued_interest, scale: 2, precision: 12
      t.decimal :amount, scale: 2, precision: 12
      t.decimal :balance, scale: 2, precision: 12, default: 0.0, null: false
      t.string :type

      t.timestamps
    end
  end
end
