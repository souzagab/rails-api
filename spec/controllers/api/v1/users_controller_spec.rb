require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :request do
    context 'Routes' do
        let(:user) { build(:user) }
        it 'Show Users' do
            get api_v1_users_path
            expect(response).to have_http_status(200)
        end
        it 'Create User' do
            post api_v1_users_path, params:{ user: attributes_for(:user) } 
            expect(response).to have_http_status(201)
        end
        it 'Update user' do
            patch api_v1_user_path(User.first.id), params:{ user: attributes_for(:user) } 
            expect(response).to have_http_status(200)
        end
        it 'Update user with invalid email' do
            patch api_v1_user_path(User.first.id), params:{ user: {email:'invalidemail.com'} } 
            expect(response).to_not have_http_status(200)
        end
        it 'Delete user' do
            delete api_v1_user_path(User.first.id)
            expect(response).to have_http_status(204)
        end
        it 'Show user' do
            get api_v1_user_path(User.first.id)
            expect(response).to have_http_status(200)
        end
    end
    
    
end


