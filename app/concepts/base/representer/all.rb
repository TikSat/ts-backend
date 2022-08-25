module Base::Representer::All
  extend ActiveSupport::Concern

  include Representable::JSON
  include Base::Representer::ToResponse

  ##
  # Методы для поддержки коллекций
  ##

  def self.included(base)
    base.extend(CollectionClassMethods)
  end

  module CollectionClassMethods
    include Base::Representer::PropertyHelpers

    def collection_representer_class
      Base::Representer::All::Collection
    end

    def with_defaults(options = {})
      defaults({ render_nil: true }.merge(options)) do |_, prop_options|
        defaults = {}

        # Скрывать файл, если объект пустой
        if prop_options.include? :decorator
          defaults[:render_filter] = lambda do |input, _options|
            if input.is_a?(Shrine)
              input.presence
            else
              input
            end
          end
        end

        defaults
      end
    end
  end

  module Collection
    def self.included(base)
      base.send :include, Representable::Hash::Collection
      base.send :include, Base::Representer::All
    end
  end
end
