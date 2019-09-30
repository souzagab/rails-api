require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :request do
    
    it 'Show Users' do
        get api_v1_users_path
        expect(response).to have_http_status(200)
    end
    
    
end


