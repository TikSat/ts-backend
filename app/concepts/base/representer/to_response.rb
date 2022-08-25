class Base::Representer < Representable::Decorator
  module ToResponse
    extend ActiveSupport::Concern

    # Метод для рендера с обработкой default nested полей
    #
    # @param options [Hash]
    def to_response(options = {})
      options = prepare_options(options.dup)

      to_hash(options)
    end

    private

    def prepare_options(options)
      return {} if options.blank?

      options.deep_symbolize_keys.each do |k, v|
        options[k] = v.map(&:to_sym) if v.is_a?(Array)
      end

      options
    end
  end
end
