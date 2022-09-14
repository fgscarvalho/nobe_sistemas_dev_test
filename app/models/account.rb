class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions
  validates :balance,  presence: true, allow_blank: false, numericality: { greater_than_or_equal_to: BigDecimal(0.0) }

  def add_money(value)
    new_balance = balance.to_s.to_d + value.to_s.to_d
    update_attribute(:balance, new_balance)
  end

  def remove_money(value)
    new_balance = balance.to_s.to_d - value.to_s.to_d
    update_attribute(:balance, new_balance)
  end

  def is_active?
    is_active == true
  end

  def close
    update_attribute(:is_active, false)
  end

  def enough_founds?(value)
    balance.to_s.to_d >= value.to_s.to_d
  end
end
