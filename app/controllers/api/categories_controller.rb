class Api::CategoriesController < ApplicationController
  _endpoint :index, Category::Fetch
  _endpoint :show, Category::Fetch::Single

  def controller_representer
    Category::Representer
  end

  def public_actions
    %i[index show]
  end
end
