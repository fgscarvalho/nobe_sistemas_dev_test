class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.decimal :balance, precision: 18, scale: 2, null: false, default: 0.00
      t.boolean :is_active, null: false, default: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
