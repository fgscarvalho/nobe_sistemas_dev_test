require 'rails_helper'

RSpec.describe Transaction do
    it { should belong_to(:account)}
    it { should define_enum_for(:kind).with_values([:deposit, :withdraw, :transfer]) }

    context 'testing deposit transaction' do
      let(:user){FactoryBot.create(:user)}
      let(:account){FactoryBot.create(:account, user: user)}
      let(:transaction){FactoryBot.create(:transaction, account: account)}
      it 'Deposit was successfully?' do
        initial_balance = account.balance
        transaction.deposit
        expect(account.balance).to eq(initial_balance + transaction.value)
      end
    end

    context 'testing withdraw transaction' do
      let(:user){FactoryBot.create(:user)}
      let(:account){FactoryBot.create(:account, balance: 100.00, user: user)}
      let(:transaction){FactoryBot.create(:transaction, account: account)}
      it 'Withdraw was successfully?' do
        initial_balance = account.balance
        transaction.withdraw
        expect(account.balance).to eq(initial_balance - transaction.value)
      end
    end

    context 'testing withdraw transaction' do
      let(:user){FactoryBot.create(:user)}
      let(:account){FactoryBot.create(:account, user: user)}
      let(:transaction){FactoryBot.create(:transaction, account: account)}
      it "Withdraw wasn't successfully?" do
        expect(transaction.withdraw).to eq(nil)
      end
    end

    context 'testing transfer transaction with balance not enough' do
      let(:user1){FactoryBot.create(:user)}
      let(:account1){FactoryBot.create(:account, balance: 100.00, user: user1)}
      let(:user2){FactoryBot.create(:user)}
      let(:account2){FactoryBot.create(:account, user: user2)}
      let(:transaction){FactoryBot.create(:transaction, account: account1)}
      it "Transfer wasn't successfully?" do
        expect(transaction.transfer(account2)).to eq(nil)
      end
    end

    context 'testing receiver transfer transaction' do
      let(:user1){FactoryBot.create(:user)}
      let(:account1){FactoryBot.create(:account, balance: 120.00, user: user1)}
      let(:user2){FactoryBot.create(:user)}
      let(:account2){FactoryBot.create(:account, user: user2)}
      let(:transaction){FactoryBot.create(:transaction, account: account1)}
      it 'Transfer was successfully?' do
        initial_balance = account1.balance
        value_with_tax = transaction.transfer(account2)
        expect(account1.balance).to eq(initial_balance - value_with_tax)
      end
    end

    context 'testing destination transfer transaction' do
      let(:user1){FactoryBot.create(:user)}
      let(:account1){FactoryBot.create(:account, balance: 120.00, user: user1)}
      let(:user2){FactoryBot.create(:user)}
      let(:account2){FactoryBot.create(:account, user: user2)}
      let(:transaction){FactoryBot.create(:transaction, account: account1)}
      it 'Transfer was successfully?' do
        initial_balance = account2.balance
        value_with_tax = transaction.transfer(account2)
        expect(account2.balance).to eq(initial_balance + transaction.value)
      end
    end
end
