class Category::Fetch < Base::Fetch
  pass :apply_root

  private

  def build_initial_scope(ctx, params:, **)
    scope = params[:category_id].present? ? Category.find(params[:category_id]).subcategories : Category.all
    ctx[:scope] = scope.includes(:custom_fields)
  end

  def apply_root(ctx, params:, scope:, **)
    return if params[:root].blank?

    ctx[:scope] = scope.root
  end
end
