require 'swagger_helper'

RSpec.describe 'api/authentication', type: :request do
  path '/api/sign_in' do
    post('sign in') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }
      response(200, 'successful') do
        let(:password) { '123456' }
        let(:user) { create :user, email: Faker::Internet.email, password: }
        let(:params) { { email: user.email, password: } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/sign_out', skip: true do
    delete('delete authentication') do
      tags 'Users'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
