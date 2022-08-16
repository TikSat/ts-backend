module TrbContext
  extend ActiveSupport::Concern

  included do |base|
    base.include Trailblazer::Endpoint::Controller.module(api: true, application_controller: true)
    base.include Pagy::Backend

    endpoint protocol: Protocols::ApiProtocol, adapter: Adapters::Representable

    def self._endpoint(name, op_class, **args)
      endpoint(name, domain_activity: op_class, **args)
    end

    def self.options_for_block_options(_ctx, controller:, **)
      response_block = lambda do |_ctx, endpoint_ctx:, **|
        # pp endpoint_ctx
        controller.success_render(**endpoint_ctx)
      end

      {
        success_block: response_block,
        failure_block: response_block,
        protocol_failure_block: response_block
      }
    end

    # this is going to endpoint_ctx
    def self.options_for_endpoint(_ctx, **)
      {
        # request: controller.request
        # errors_representer_class: App::Api::V1::Representer::Errors,
        # errors: Trailblazer::Endpoint::Adapter::API::Errors.new,
      }
    end

    # this is going to Trb operation
    def self.options_for_domain_ctx(_ctx, controller:, **)
      {
        params: controller.params.permit!,
        current_user: controller.current_user,
        current_profile: controller.current_profile
      }
    end

    directive :options_for_block_options, method(:options_for_block_options)
    directive :options_for_endpoint, method(:options_for_endpoint)
    directive :options_for_domain_ctx, method(:options_for_domain_ctx)

    def success_render(pagy:, json:, status:, **)
      pagy_headers_merge(pagy) if pagy
      render json:, status:
    end
  end
end
