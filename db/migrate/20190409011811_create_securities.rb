class CreateSecurities < ActiveRecord::Migration[5.2]
  def change
    create_table :securities do |t|
      t.references :issuer, foreign_key: true
      t.string :name
      t.string :type
      t.boolean :is_active, default: true, null:false
      t.string :currency, default: 'usd', null: false
      t.boolean :is_cash, default: false, null: false

      t.timestamps
    end
  end
end
