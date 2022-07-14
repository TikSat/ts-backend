require 'swagger_helper'

RSpec.describe 'api/users/passwords', type: :request do
  path '/api/users/passwords' do
    patch('update password') do
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