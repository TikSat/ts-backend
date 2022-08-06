class Api::ProfilesController < ApplicationController
  def index
    return if stale?(scope)

    present scope
  end

  def show
    present model
  end

  def create
    present run(Profile::Operation::Create)[:model]
  end

  def update
    present run(Profile::Operation::Update)[:model]
  end

  def destroy
    model.destroy
    head :ok
  end

  def toggle
    current_user.toggle_profile(profile)
    head :ok
  end

  private

  def profile_params
    params.permit(:name, :first_name, :last_name, :middle_name, :gender, :language, :profile_type, :avatar, :cover, :country, :city, :address_1, :address_2, :postal_code, :currency)
  end

  def scope
    @scope ||= fetch_scope(Profile::Fetch)
  end

  def model
    @model ||= scope.find(params[:id])
  end

  def profile
    @profile = current_user.profiles.find(params[:id])
  end
end
