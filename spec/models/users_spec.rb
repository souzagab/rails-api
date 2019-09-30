require 'rails_helper'
RSpec.describe User, type: :model do
  
  context 'New user' do
    let(:user) { build(:user) }

    it { is_expected.to be_mongoid_document }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :name }

    it 'with valid email' do
        # user = User.new(name:'test',password:'test123',email:'test@teste.org')
        expect(user).to be_valid
    end
    it 'with invalid email shouldnt pass' do
      user.email = 'test.org'
      expect(user).to_not be_valid
    end
    it 'missmatch password shouldnt pass' do
      user.password_confirmation = 'tt123'
      expect(user).to_not be_valid
      expect(user.errors.messages[:password_confirmation]).to include("doesn't match Password")
    end

    # context 'when email should be unique' do
    #   let!(:old_user) { build(:user) }

    #   it 'with same email as registered' do
    #     user = User.new(name:'test',password:'test123',email: old_user.email)
    #     expect(user).to_not be_valid
    #     expect(user.errors.messages[:email]).to include("is already taken")
    #   end
    # end


  end
end
