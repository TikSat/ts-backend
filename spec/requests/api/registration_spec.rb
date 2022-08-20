require 'swagger_helper'

RSpec.describe 'api/registration', type: :request do
  let(:params) { { email: Faker::Internet.email, password: '123456', password_confirmation: '123456' } }

  path '/api/sign_up' do
    post('create registration') do
      tags 'User', 'Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: 'string',
          password: 'string',
          password_confirmation: 'string'
        }
      }, required: true

      response(200, 'user created') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test! do
          expect(json_response[:token]).to be_present
          expect(json_response[:refresh_token]).to be_present
          expect(json_response[:token_expire_at]).to be_present
        end
      end
    end
  end
end
