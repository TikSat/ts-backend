class Profile::Operation::Toggle < Base::Operation
  step Model(Profile, :find_by)
  step :toggle

  private

  def toggle(_ctx, model:, current_user:, **)
    UserProfile.transaction do
      current_user.user_profiles.update_all(current: false)
      current_user.user_profiles.where(profile_id: model.id).update!(current: true)
    end
  end
end
