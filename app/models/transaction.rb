class Transaction < ApplicationRecord
  belongs_to :account

  TAX_WEEKDAY = 5.0
  TAX_WEEKEND = 7.0
  TAX_MAX_VALUE = 10.0
  SUNDAY = 0
  SATURDAY = 6
  START_TIME = "09:00:00"
  FINISH_TIME = "18:00:00"

  enum kind: %i[deposit withdraw transfer].freeze


  def deposit
    account.add_money(value)
  end

  def withdraw
    account.remove_money(value)
  end

  def transfer(destination_account)
    date = Time.now
    value_with_tax = value
    if (date.wday > SUNDAY and date.wday < SATURDAY) and (Time.now.between?(Time.parse(START_TIME),Time.parse(FINISH_TIME)))
      value_with_tax += TAX_WEEKDAY
    else
      value_with_tax += TAX_WEEKEND
    end

    if value > 1000.0
      value_with_tax += TAX_MAX_VALUE
    end

    if account.remove_money(value_with_tax) != nil
      account.remove_money(value_with_tax)
      destination_account.add_money(value)
    else
      return nil
    end

    value_with_tax
  end
end
