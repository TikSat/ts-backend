class Api::ProfilesController < ApplicationController
  _endpoint :index, Profile::Fetch
  _endpoint :show, Profile::Fetch
  _endpoint :create, Profile::Operation::Create
  _endpoint :update, Profile::Operation::Update
  _endpoint :destroy, Profile::Operation::Destroy
end
