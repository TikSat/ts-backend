class Listing::Fetch::Recommended < Base::Fetch
  private

  def build_initial_scope(ctx, **)
    ctx[:scope] = Listing.all.includes(:author, :custom_fields, category: :custom_fields).order(:created_at)
  end
end
