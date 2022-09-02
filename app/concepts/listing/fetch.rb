class Listing::Fetch < Base::Fetch
  private

  def build_initial_scope(ctx, params:, **)
    ctx[:scope] = Listing.where(category: { slug: params[:category_id] })
                         .includes(:custom_fields, :author, :category).order(:created_at)
  end
end
