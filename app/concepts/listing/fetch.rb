class Listing::Fetch < Base::Fetch

  private

  def build_initial_scope(ctx, params:, **)
    ctx[:scope] = Listing.where(category_id: params[:category_id])
                         .includes(:custom_fields, :author)
  end
end
