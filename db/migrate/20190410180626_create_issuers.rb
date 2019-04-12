class CreateIssuers < ActiveRecord::Migration[5.2]
  def change
    create_table :issuers do |t|
      t.string :name
      t.boolean :is_active, default: true, null:false

      t.timestamps
    end
  end
end
