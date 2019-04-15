class CreateSecurities < ActiveRecord::Migration[5.2]
  def change
    create_table :securities do |t|
      t.references :account, foreign_key: true
      t.integer :issuer_id
      t.string :name
      t.boolean :is_active, default: true, null:false
      t.string :currency, default: 'usd', null: false
      t.string :type
      t.timestamps
    end
  end
end
