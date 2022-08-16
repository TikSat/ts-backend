class Profile::Operation::Destroy < Base::Operation
  step Model(Profile, :find_by)
  step :destroy

  private

  def destroy(_ctx, model:, **)
    model.destroy
  end
end
