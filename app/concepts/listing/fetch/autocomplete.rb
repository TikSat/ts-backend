class Listing::Fetch::Autocomplete < Base::Fetch
  private

  def build_initial_scope(ctx, params:, **)
    ctx[:scope] = Listing.includes(:category).search_by_title(params[:q])
  end
end
