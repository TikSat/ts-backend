class Api::Admin::CategoriesController < Api::Admin::BaseController
  def index
    # TODO: fix N+1
    categories = Category.includes(:subcategories, :custom_fields,
                                   { subcategories: %i[subcategories custom_fields] }).root
    return unless stale?(categories)

    present categories
  end

  def show
    category = Category.find(params[:id])
    return unless stale?(category)

    present category
  end

  def create
    category = Category.create(category_params)
    present category
  end

  def update
    category.update(category_params)
    present category
  end

  def destroy
    head :ok if category.destroy
  end

  private

  def category_params
    params.permit(:name, :desc, :image, :parent_id)
  end

  def category
    @category ||= Category.find(params[:id])
  end
end
