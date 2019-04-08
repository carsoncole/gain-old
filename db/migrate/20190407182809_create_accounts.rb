class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :title
      t.string :number

      t.timestamps
    end
  end
end
