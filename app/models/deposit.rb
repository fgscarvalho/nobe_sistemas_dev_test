class Deposit < Transaction
  #add money in account
  def execute
    account.balance += value
  end
end
