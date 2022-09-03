class Api::CategoriesController < ApplicationController
  _endpoint :index, Category::Fetch
  _endpoint :show, Category::Fetch::Single

  def controller_representer
    Category::Representer
  end

  # TODO: move to operations | CAST VALUES FUCK IT!!!
  def ids
    render json: Category.all.pluck(:slug)
  end

  def breadcrumbs
    category = Category.find(params[:category_id])
    render json: category.parents.pluck(:name, :slug).reverse
  end

  def public_actions
    %i[index show ids breadcrumbs]
  end
end
