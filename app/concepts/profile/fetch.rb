class Profile::Fetch

  private

  def build_initial_scope(ctx, current_user:, **)
    ctx[:scope] = current_user.profiles
  end
end
