class CreateSecurities < ActiveRecord::Migration[5.2]
  def change
    create_table :securities do |t|
      t.references :issuer, foreign_key: true
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
