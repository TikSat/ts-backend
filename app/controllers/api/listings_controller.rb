class Api::ListingsController < ApplicationController
  skip_before_action :authenticate_resource, only: %i[index show]

  def index
    listings = category.listings.includes(:custom_fields, :author)
    return unless stale?(listings)

    present listings
  end

  def show
    return unless stale?(listing)

    present listing
  end

  def create
    listing = current_profile.listings.create(listing_params)
    present listing
  end

  def update
    listing.update(listing_params)
    present listing
  end

  def destroy
    listing.destroy
  end

  private

  def category
    @category = Category.friendly.find(params[:category_id])
  end

  def listing
    @listing = category.listings.find(params[:id])
  end

  # TODO: add params
  def listing_params
    params.permit!
  end
end
