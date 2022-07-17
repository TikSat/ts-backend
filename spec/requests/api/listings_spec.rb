require 'swagger_helper'

RSpec.describe 'api/listings', type: :request do
  path '/api/categories/{category_id}/listings' do
    # You'll want to customize the parameter types...
    parameter name: 'category_id', in: :path, type: :string, description: 'category_id'

    get('list listings') do
      response(200, 'successful') do
        let(:category_id) { '123' }

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

    post('create listing') do
      response(200, 'successful') do
        let(:category_id) { '123' }

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

  path '/api/categories/{category_id}/listings/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'category_id', in: :path, type: :string, description: 'category_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show listing') do
      response(200, 'successful') do
        let(:category_id) { '123' }
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

    patch('update listing') do
      response(200, 'successful') do
        let(:category_id) { '123' }
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

    put('update listing') do
      response(200, 'successful') do
        let(:category_id) { '123' }
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

    delete('delete listing') do
      response(200, 'successful') do
        let(:category_id) { '123' }
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
