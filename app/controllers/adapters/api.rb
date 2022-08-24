class Adapters::Api < Trailblazer::Endpoint::Adapter::API
  Error = Struct.new(:message, :errors, :details)

  include Pagy::Backend

  step :render # added before End.success
  step :render_errors, after: :_422_status, magnetic_to: :failure, Output(:success) => Track(:failure)
  step :render_errors, after: :protocol_failure, magnetic_to: :fail_fast, Output(:success) => Track(:fail_fast), id: :render_protocol_failure_errors

  def render(ctx, domain_ctx:, pagination: false, representer: Base::Representer::Success, **)
    pagy, items = if pagination
                    paginate(params: domain_ctx[:params], scope: domain_ctx[:scope])
                  else
                    [nil, domain_ctx[:model]]
                  end
    decorator = representer || representer_for(items)
    ctx[:pagy] = pagy
    ctx[:representer] = decorator.represent(items)
  end

  def render_errors(ctx, errors:, errors_representer_class:, **)
    ctx[:representer] = errors_representer_class.represent(errors)
  end

  def representer_for(object)
    obj = object.is_a?(Array) ? object.first : object
    from_class = "#{obj.class.name}Representer"
    from_class.safe_constantize
  end

  def paginate(params:, scope:)
    pagy = Pagy.new(count: scope.count, page: params[Pagy::DEFAULT[:page_param]])
    items = pagy_get_items(scope, pagy)
    [pagy, items.to_a]
  end

  # errors handlers
  Trailblazer::Endpoint::Adapter::API.insert_error_handler_steps!(self)

  def handle_not_authenticated(_ctx, errors:, **)
    errors.message = 'Authentication credentials were not provided or are invalid.'
  end

  def handle_not_authorized(_ctx, errors:, **)
    errors.message = 'Action not allowed due to a policy setting.'
  end

  def handle_invalid_data(_ctx, errors:, domain_ctx:, **)
    errors.details = []
    errors.details << domain_ctx[:'contract.default'].errors.messages if domain_ctx[:'contract.default']&.errors.present?
    errors.details << domain_ctx[:model].errors if domain_ctx[:model]&.errors.present?
    errors.message = 'The submitted data is invalid.'
    true
  end
end
