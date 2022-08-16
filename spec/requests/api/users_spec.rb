require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  let(:user) { create :user }
  let(:profile) { create :profile, users: [user] }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:Authorization) { 'Bearer ' + token.first }
  let(:id) { profile.id }

  path '/api/me' do
    get('show user') do
      tags 'Users'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

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
