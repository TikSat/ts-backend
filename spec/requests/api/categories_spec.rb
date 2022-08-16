require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  path '/api/categories' do
    get('list categories') do
      tags 'Categories'
      parameter name: :page, in: :query, type: :integer, description: 'Page for pagination', required: false
      parameter name: :items, in: :query, type: :integer, description: 'Number of items per page', required: false

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
