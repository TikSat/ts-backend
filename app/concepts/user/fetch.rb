class User::Fetch < Base::Fetch
  private

  def build_initial_scope(ctx, current_user:, **)
    ctx[:model] = current_user
  end
end
