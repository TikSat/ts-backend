class ApplicationController < ActionController::API
  DEFAULT_ACTIONS = %i[index show create update destroy].freeze

  include TrbContext

  # override in specific controller
  def controller_representer
    nil
  end

  # define actions without auth
  def public_actions
    []
  end

  DEFAULT_ACTIONS.each do |action|
    define_method(action) do
      endpoint action, pagination: action == :index,
                       representer: controller_representer,
                       skip_auth: public_actions.include?(action)
    end
  end
end
