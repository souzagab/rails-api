require 'rails_helper'
RSpec.describe User, type: :model do
  
  context 'New' do

   
    it 'with valid email' do
        user = User.new(name:'test',password:'test123',email:'test@test.org')
        expect(user.save).to be true
    end
    it 'with invalid email shouldnt pass' do
      user = User.new(name:'test',password:'test123',email:'test.org')
      expect(user.save).to be false
    end
    it 'missmatch password shouldnt pass' do
      user = User.new(name:'test',password:'test123',password_confirmation:'tt123',email:'tes@t.org')
      expect(user.save).to be false
    end


  end
end
