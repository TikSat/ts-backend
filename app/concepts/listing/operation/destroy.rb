class Listing::Operation::Destroy < Base::Operation
  step Model(Listing, :find_by, not_found_terminus: true)
  step :destroy

  private

  def destroy(_ctx, model:, **)
    model.destroy
  end
end
