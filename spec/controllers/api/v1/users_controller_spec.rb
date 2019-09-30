require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :request do
    context 'Routes' do
        let(:user) { build(:user) }
        let(:first_user) { User.first }
        it 'Show Users' do
            get api_v1_users_path
            expect(response).to have_http_status(200)
        end
        it 'Create User' do
            post api_v1_users_path, params:{ user: attributes_for(:user) } 
            expect(response).to have_http_status(201)
        end
        it 'should update user' do
            patch api_v1_user_path(first_user.id), 
            params:{ user: attributes_for(:user) } , 
            headers: { Authorization: JsonWebToken.encode(user_id: first_user.id)}
            expect(response).to have_http_status(200)
        end
        it 'forbid update user' do
            patch api_v1_user_path(first_user.id), 
            params:{ user: attributes_for(:user) } 
            expect(response).to have_http_status(403)
        end

        it 'Update user with invalid email' do
            patch api_v1_user_path(first_user.id), params:{ user: {email:'invalidemail.com'} } 
            expect(response).to_not have_http_status(200)
        end
        it 'Delete user' do
            delete api_v1_user_path(first_user.id) , headers: { Authorization: JsonWebToken.encode(user_id: first_user.id)}
            expect(response).to have_http_status(204)
        end
        it 'forbid delete user' do
            delete api_v1_user_path(first_user.id)
            expect(response).to have_http_status(403)
        end
        it 'Show user' do
            get api_v1_user_path(first_user.id)
            expect(response).to have_http_status(200)
        end
    end
    
    
end


