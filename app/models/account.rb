class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def add_money(value)
    new_balance = balance.to_s.to_d + value.to_s.to_d
    update_attribute(:balance, new_balance)
  end

  def remove_money(value)
    balance -= value
  end
end
