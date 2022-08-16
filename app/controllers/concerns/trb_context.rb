module TrbContext
  extend ActiveSupport::Concern

  included do |base|
    base.include Trailblazer::Endpoint::Controller.module(api: true, application_controller: true)
    base.include Pagy::Backend

    endpoint protocol: Protocols::Api, adapter: Adapters::Api

    def self._endpoint(name, op_class, **args)
      endpoint(name, domain_activity: op_class, **args)
    end

    def self.options_for_block_options(_ctx, controller:, **)
      success_response = lambda do |_ctx, endpoint_ctx:, **|
        controller.success_render(endpoint_ctx)
      end

      failure_response = lambda do |_ctx, endpoint_ctx:, **|
        controller.error_render(endpoint_ctx)
      end

      {
        success_block: success_response,
        failure_block: failure_response,
        protocol_failure_block: failure_response
      }
    end

    # this is going to endpoint_ctx
    def self.options_for_endpoint(_ctx, controller:, **)
      {
        request: controller.request,
        errors_representer_class: Base::Representer::Error,
        errors: Adapters::Api::Error.new
      }
    end

    # this is going to Trb operation
    def self.options_for_domain_ctx(_ctx, controller:, **)
      {
        params: controller.params.permit!
      }
    end

    directive :options_for_block_options, method(:options_for_block_options)
    directive :options_for_endpoint, method(:options_for_endpoint)
    directive :options_for_domain_ctx, method(:options_for_domain_ctx)

    def success_render(ctx)
      pagy_headers_merge(ctx[:pagy]) if ctx[:pagy]
      render json: ctx[:representer].to_hash(params[:response] || {}), status: ctx[:status]
    end

    def error_render(ctx)
      render json: ctx[:representer].to_hash(params[:response] || {}), status: ctx[:status]
    end
  end
end
