class AddNumberAccountToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :number_account, :string
  end
end
