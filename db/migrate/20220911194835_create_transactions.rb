class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.decimal :value, precision: 18, scale: 2, null: false
      t.timestamps
    end
  end
end
