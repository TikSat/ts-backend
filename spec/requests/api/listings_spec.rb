require 'swagger_helper'

RSpec.describe 'api/listings', type: :request do
  let(:user) { create :user_with_profiles }
  let(:profile) { user.current_profile }
  let(:token) { jwt_and_refresh_token(user, 'user') }
  let(:Authorization) { 'Bearer ' + token.first }
  let(:category) { create :category }
  let(:category_id) { category.slug }
  let(:profile_id) { profile.id }
  let(:listing_params) { { category_id: category.id, profile_id:, title: 'Cool' } }

  path '/api/listings' do
    post('create listing') do
      tags 'Listings'
      security [Bearer: {}]
      consumes 'application/json'
      parameter name: :listing_params, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          profile_id: { type: :integer },
          category_id: { type: :integer }
        }
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do
          expect(Listing.last.title).to eq 'Cool'
        end
      end
    end
  end

  path '/api/listings/{id}' do
    let(:listing) { create :listing, profile_id: user.current_profile.id }
    let(:id) { listing.slug }
    let(:listing_params) { { title: 'Cool too' } }

    patch('update listing') do
      tags 'Listings'

      response(200, 'successful') do
        security [Bearer: {}]
        consumes 'application/json'
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string, description: 'Listing ID'
        parameter name: :listing_params, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            profile_id: { type: :integer },
            category_id: { type: :integer }
          }
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test! do
          expect(listing.reload.title).to eq 'Cool too'
        end
      end
    end

    delete('delete listing') do
      tags 'Listings'

      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :id, in: :path, type: :string, description: 'Listing ID'

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

  path '/api/categories/{category_id}/listings' do
    parameter name: 'category_id', in: :path, type: :string, description: 'category_id'

    get('list listings') do
      tags 'Listings'
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

  path '/api/categories/{category_id}/listings/{id}' do
    parameter name: 'category_id', in: :path, type: :string, description: 'category_id'
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show listing') do
      tags 'Listings'

      let(:listing) { create :listing, category_id: category.id }
      let(:id) { listing.slug }

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
