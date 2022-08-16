require 'swagger_helper'

RSpec.describe 'api/profiles', type: :request do
  let(:user) { create :user }
  let(:profile) { create :profile, users: [user] }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:Authorization) { 'Bearer ' + token.first }
  let(:id) { profile.id }

  path '/api/profiles/{id}/toggle' do
    post('toggle profile') do
      tags 'Profiles'
      parameter name: 'id', in: :path, type: :string, description: 'profile id'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string

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

  path '/api/profiles' do
    get('list profiles') do
      tags 'Profiles'
      security [Bearer: {}]
      parameter name: :Authorization, in: :header, type: :string
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

    post('create profile') do
      tags 'Profiles'
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

  path '/api/profiles/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show profile') do
      tags 'Profiles'
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

    patch('update profile') do
      tags 'Profiles'
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

    put('update profile') do
      tags 'Profiles'
      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string

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

    delete('delete profile') do
      tags 'Profiles'
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
