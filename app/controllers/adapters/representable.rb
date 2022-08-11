class Adapters::Representable < Trailblazer::Endpoint::Adapter::API
  include Pagy::Backend
  step :render # added before End.success
  step :render_errors, after: :_422_status, magnetic_to: :failure, Output(:success) => Track(:failure)
  step :render_errors, after: :protocol_failure, magnetic_to: :fail_fast, Output(:success) => Track(:fail_fast), id: :render_protocol_failure_errors

  def render(ctx, domain_ctx:, pagination:, representer:, **)
    pagy, items = if pagination
                    paginate(params: domain_ctx[:params], scope: domain_ctx[:scope])
                  else
                    [nil, domain_ctx[:model]]
                  end
    decorator = representer || representer_for(items)
    ctx[:pagy] = pagy
    ctx[:json] = decorator.represent(items).to_hash(domain_ctx[:params][:response] || {})
  end

  def render_errors(ctx, errors:, errors_representer_class:, **)
    ctx[:representer] = errors_representer_class.new(errors)
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

  Trailblazer::Endpoint::Adapter::API.insert_error_handler_steps!(self)
  include Trailblazer::Endpoint::Adapter::API::Errors::Handlers
end
