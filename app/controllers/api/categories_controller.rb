class Api::CategoriesController < ApplicationController
  skip_before_action :authenticate_resource

  def index
    categories = Category.includes(:subcategories,
                                   { subcategories: :subcategories }).root
    return unless stale?(categories)

    present categories
  end

  def show
    category = Category.friendly.find(params[:id])
    return unless stale?(category)

    present category
  end
end
