class Listing::Fetch::Recommended < Base::Fetch

  private

  def build_initial_scope(ctx, **)
    ctx[:scope] = Listing.all
  end
end
