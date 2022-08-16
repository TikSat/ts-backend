class Api::ProfilesController < ApplicationController
  _endpoint :index, Profile::Fetch
  _endpoint :show, Profile::Fetch::Single
  _endpoint :create, Profile::Operation::Create
  _endpoint :update, Profile::Operation::Update
  _endpoint :destroy, Profile::Operation::Destroy
  _endpoint :toggle, Profile::Operation::Toggle

  def toggle
    endpoint :toggle, representer: Base::Representer::Success
  end

  def controller_representer
    Profile::Representer
  end
end
