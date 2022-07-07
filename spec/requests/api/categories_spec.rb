require 'swagger_helper'

RSpec.describe 'api/categories', type: :request do
  path '/api/categories' do
    get('list categories') do
      tags 'Categories'
      parameter name: :page, in: :query, type: :integer, description: 'Page for pagination'
      parameter name: :items, in: :query, type: :integer, description: 'Number of items per page'
      produces 'application/json'

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

  path '/api/categories/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show category') do
      tags 'Categories'
      response(200, 'successful') do
        let(:id) { '123' }

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
