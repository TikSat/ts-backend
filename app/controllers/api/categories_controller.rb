class Api::CategoriesController < ApplicationController
  skip_before_action :authenticate_resource

  _endpoint :index, Category::Fetch

  def controller_representer
    @controller_representer ||= CategoryRepresenter
  end
end
