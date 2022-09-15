require 'rails_helper'

RSpec.describe Account do
  it { should belong_to(:user) }
  it { should have_many(:transactions)}
  it { should validate_presence_of :balance }
  it { validate_numericality_of :balance }

  context 'testing activity of a account' do
    let(:user){FactoryBot.create(:user)}
    it 'Account is active?' do
      account = FactoryBot.create(:account, user: user)
      expect(account.is_active?).to be_truthy
    end
  end

  context 'testing addtion money in account' do
    let(:user){FactoryBot.create(:user)}
    let(:account){FactoryBot.create(:account, balance: 10.0, user: user )}
    it 'Did the balance increase?' do
      initial_balance =  account.balance
      account.add_money(10.0)
      expect(account.balance).to eq(initial_balance + 10.0)
    end
  end

  context 'testing romove money in account' do
    let(:user){FactoryBot.create(:user)}
    let(:account){FactoryBot.create(:account, balance: 10.0, user: user )}
    let(:value){9.8}
    it 'Did the balance decrease?' do
      initial_balance =  account.balance
      account.remove_money(value)
      expect(account.balance).to eq(initial_balance - value)
    end
  end

  context 'testing romove money in account' do
    let(:user){FactoryBot.create(:user)}
    let(:account){FactoryBot.create(:account, balance: 10.0, user: user )}
    let(:value){10.1}
    it 'Did the balance decrease?' do
      account.remove_money(value)
      expect(account.remove_money(value)).to eq(nil)
    end
  end


  context 'testing activity of a account if is close' do
    let(:user){FactoryBot.create(:user)}
    let(:account){FactoryBot.create(:account, user: user )}
    it 'Account is closed?' do
      account.close
      expect(account.is_active?).to be_falsey
    end
  end

  context 'testing if the balance is positive' do
    let(:user){FactoryBot.create(:user)}
    it 'Are the enough funds?' do
      account = FactoryBot.create(:account, balance: 10.5, user: user)
      expect(account.enough_funds?(10.0)).to be_truthy
    end
  end

  context 'testing if the balance is negative' do
    let(:user){FactoryBot.create(:user)}
    it 'Are the enough funds?' do
      account = FactoryBot.create(:account, balance: 10.5)
      expect(account.enough_funds?(10.7)).to be_falsey
    end
  end
end
