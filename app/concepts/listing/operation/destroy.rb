class Listing::Operation::Destroy < Base::Operation
  step Model(Listing, :find_by)
  step :destroy

  private

  def destroy(_ctx, model:, **)
    model.destroy
  end
end
