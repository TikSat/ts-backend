class ApplicationController < ActionController::API
  include TrbContext

  %i[index show create update destroy].each do |page|
    define_method(page) do
      endpoint page, pagination: page == :index, representer: controller_representer
    end
  end

  # override in specific controller
  def controller_representer
    nil
  end
end
