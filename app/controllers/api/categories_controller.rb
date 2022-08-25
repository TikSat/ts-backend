class Api::CategoriesController < ApplicationController
  _endpoint :index, Category::Fetch
  _endpoint :show, Category::Fetch::Single

  def controller_representer
    Category::Representer
  end

  def ids
    hash = ActiveRecord::Base.connection.execute('SELECT array_agg(listings.id) as listings_ids, listings.category_id from listings group by listings.category_id')
    render json: hash
  end

  def public_actions
    %i[index show]
  end
end
