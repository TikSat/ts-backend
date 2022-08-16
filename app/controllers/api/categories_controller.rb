class Api::CategoriesController < ApplicationController
  _endpoint :index, Category::Fetch

  def controller_representer
    Category::Representer
  end
end
