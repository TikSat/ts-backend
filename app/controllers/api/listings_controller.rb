class Api::ListingsController < ApplicationController
  _endpoint :index, Listing::Fetch
  _endpoint :show, Listing::Fetch::Single
  _endpoint :create, Listing::Operation::Create
  _endpoint :update, Listing::Operation::Update
  _endpoint :destroy, Listing::Operation::Destroy
  _endpoint :recommended, Listing::Fetch::Recommended

  def controller_representer
    Listing::Representer
  end

  def recommended
    endpoint :recommended, pagination: true,
                           skip_auth: true,
                           representer: controller_representer
  end

  def ids
    render json: Listing.where(category_id: params[:category_id]).ids
  end

  def public_actions
    %i[index show]
  end
end
