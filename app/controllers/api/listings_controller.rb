class Api::ListingsController < ApplicationController
  skip_before_action :authenticate_resource, only: %i[index show]
  _endpoint :index, Listing::Fetch
  _endpoint :show, Listing::Fetch
  _endpoint :create, Listing::Operation::Create
  _endpoint :update, Listing::Operation::Update
  _endpoint :destroy, Listing::Operation::Destroy
end