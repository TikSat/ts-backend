class Category::Fetch < Base::Fetch
  pass :apply_root

  private

  def build_initial_scope(ctx, **)
    ctx[:scope] = Category.all
  end

  def apply_root(ctx, params:, scope:, **)
    return if params[:root].blank?

    ctx[:scope] = scope.root
  end
end
