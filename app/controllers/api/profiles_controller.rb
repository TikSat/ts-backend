class Api::ProfilesController < ApplicationController
  _endpoint :index, Profile::Fetch
  _endpoint :show, Profile::Fetch::Single
  _endpoint :create, Profile::Operation::Create
  _endpoint :update, Profile::Operation::Update
  _endpoint :destroy, Profile::Operation::Destroy

  def toggle
    render json: { status: :ok }
  end

  def controller_representer
    ProfileRepresenter
  end
end
