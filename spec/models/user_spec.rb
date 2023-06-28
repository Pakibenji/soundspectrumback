require 'rails_helper'
RSpec.describe User, type: :model do
    describe 'validations' do
      it 'is valid with valid attributes' do
        user = User.new(email: 'test@gmail.com', password: 'Password@2023', role: 'user')
        expect(user).to be_valid
      end
  
      it 'is not valid without an email' do
        user = User.new(password: 'Password@2023', role: 'user')
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include("can't be blank")
      end
  
      it 'is not valid without a password' do
        user = User.new(email: 'test@gmail.com', role: 'user')
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include("can't be blank")
      end
    end
  
    describe 'admin role' do
      it 'is assigned to the user' do
        user = User.create!(email: 'test@gmail.com', password: 'Password@2023', role: 'admin')
        expect(user.role).to eq('admin')
        expect(user.admin?).to be_truthy
      end
  
      it 'is not assigned by default' do
        user = User.create!(email: 'test@gmail.com', password: 'Password@2023', role: 'user')
        expect(user.role).to eq('user')
        expect(user.admin?).to be_falsy
      end
    end
  end