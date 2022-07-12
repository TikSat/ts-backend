class API::ProfilesController < ApplicationController
  def index
    present current_user.profiles
  end

  def show
    present current_user.current_profile
  end

  def create
    profile = current_user.profiles.create(profile_params)
    present profile
  end

  def update
    profile.update(profile_params)
    present profile
  end

  def destroy
    profile.destroy
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

  def profile
    @profile = current_user.profiles.find(params[:id])
  end
end
