class Api::ListingsController < ApplicationController
  skip_before_action :authenticate_resource, only: %i[index show]

  def index
    return unless stale?(scope)

    present scope
  end

  def show
    return unless stale?(model)

    present model
  end

  def create
    present run(Listing::Operation::Create)[:model]
  end

  def update
    present run(Listing::Operation::Update)[:model]
  end

  def destroy
    model.destroy
    head :ok
  end

  private

  def scope
    @scope ||= fetch_scope(Listing::Fetch)
  end

  def model
    @model ||= scope.find(params[:id])
  end

  # TODO: add params
  def listing_params
    params.permit!
  end
end
