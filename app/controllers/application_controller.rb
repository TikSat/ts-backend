class ApplicationController < ActionController::API
  include TrbContext
  before_action :authenticate_resource

  %i[index show create update destroy].each do |page|
    define_method(page) do
      endpoint page, pagination: page == :index, representer: controller_representer
    end
  end

  alias current_user current_resource

  # TODO: move to protocol
  def authenticate_resource
    authenticate_and_set_user
  end

  def current_profile
    current_user&.current_profile
  end

  # override in specific controller
  def controller_representer
    nil
  end
end
