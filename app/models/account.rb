require 'faker'
class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :balance,  presence: true, allow_blank: false, numericality: { greater_than_or_equal_to: BigDecimal(0.0) }

  def new_account
    number_account = Faker::Bank.unique.account_number(digits: 10)
    update_attribute(:number_account, number_account)
  end

  def enough_funds?(value)
    balance.to_s.to_d >= value.to_s.to_d
  end

  def add_money(value)
    new_balance = balance.to_s.to_d + value.to_s.to_d
    update_attribute(:balance, new_balance)
  end

  def remove_money(value)
    if enough_funds?(value)
      new_balance = balance.to_s.to_d - value.to_s.to_d
      update_attribute(:balance, new_balance)
    end
  end

  def is_active?
    is_active == true
  end

  def close
    update_attribute(:is_active, false)
  end
end
