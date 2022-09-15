require 'rails_helper'

RSpec.describe User do
  it { should have_one(:account)}

  context 'testing validity of a user' do
    it 'User is valid?' do
      user = FactoryBot.create(:user)
      expect(user.valid?).to be_truthy
    end
  end

  context 'testing user without email' do
    it 'User is valid?' do
      user = FactoryBot.create(:user)
      user.email = ""
      expect(user.valid?).to be_falsey
    end
  end

  context 'testing user without password' do
    it 'User is valid?' do
      user = FactoryBot.create(:user)
      user.password = ""
      expect(user.valid?).to be_falsey
    end
  end
end
