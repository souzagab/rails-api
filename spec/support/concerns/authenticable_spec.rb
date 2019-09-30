require 'spec_helper'

class MockController 
    include Authenticable 
    attr_accessor :request
    def initialize
        mock_request = Struct.new(:headers) 
        self.request = mock_request.new({})
    end 
end

RSpec.describe Authenticable do
    let(:user) { User.first }
    let(:auth) { MockController.new }
    it 'get user from auth token ' do
       
        
        auth.request.headers['Authorization'] = JsonWebToken.encode(user_id: user.id)
        expect(user.id).to eq(auth.current_user.id)
    end
    it 'dont get user from empty token' do
        auth.request.headers['Authorization'] = nil
        expect(auth.current_user).to be_nil
    end
end