require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :request do

  context 'Token' do
    let(:user) { create(:user) }
    context 'Valid User' do
      it 'should get token' do
        post api_v1_tokens_path	, params: {user: {email:user.email,password:user.password}}
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to_not be_nil
      end
    end
    context 'Invalid user' do
      it 'do not generate token' do
        post api_v1_tokens_path	, params: {user: {email:user.email,password:'lorem'}}
        expect(response).to have_http_status(401)
      end
    end
  end

end
