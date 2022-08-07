class Api::CategoriesController < ApplicationController
  skip_before_action :authenticate_resource

  def index
    categories = fetch_scope(Category::Fetch)
    return unless stale?(categories)

    present categories
  end

  def show
    category = Category.find(params[:id])
    return unless stale?(category)

    present category
  end
end
