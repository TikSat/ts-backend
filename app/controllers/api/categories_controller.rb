class Api::CategoriesController < ApplicationController
  _endpoint :index, Category::Fetch
  _endpoint :show, Category::Fetch::Single

  def controller_representer
    Category::Representer
  end

  def ids
    hash = ActiveRecord::Base.connection.execute('SELECT array_agg(listings.slug) as listings_ids, categories.slug as category_id from listings INNER JOIN categories ON listings.category_id = categories.id group by categories.slug')
    render json: hash
  end

  def public_actions
    %i[index show]
  end
end
