class API::CategoriesController < ApplicationController
  def index
    categories = Category.includes(:subcategories,
                                   { subcategories: :subcategories }).root
    return unless stale?(categories)

    present categories
  end

  def show
    category = Category.find(params[:id])
    return unless stale?(category)

    present category
  end
end
