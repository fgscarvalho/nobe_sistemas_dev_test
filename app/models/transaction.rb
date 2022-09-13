class Transaction < ApplicationRecord
  belongs_to :account

  def deposit
    account.add_money(value)
  end

  def withdraw
    account.remove_money(value)
  end

  def transfer(account_to_deposit)
    account.withdraw
    account_to_deposit.deposite(account.number)
  end
end
