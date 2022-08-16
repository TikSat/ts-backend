require 'swagger_helper'

RSpec.describe 'api/users/tokens', type: :request, skip: true do
  path '/api/users/tokens' do
    post('create token') do
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
