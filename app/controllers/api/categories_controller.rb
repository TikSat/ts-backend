class API::CategoriesController < ApplicationController

  def index
    @pagy, categories = pagy(Category.root)
    return unless stale?(categories)

    render json: CategorySerializer.new(categories)
                                   .serializable_hash.to_json
  end

  def show
    category = Category.find(params[:id])
    return unless stale?(category)

    render json: CategorySerializer.new(category)
                                   .serializable_hash.to_json
  end
end
