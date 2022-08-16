require 'representable/decorator'

class Base::Representer < Representable::Decorator
  include Representable::JSON
  property :type, getter: ->(represented:, **) { represented.class.name&.underscore }
  property :decorator, getter: ->(decorator:, **) { decorator.class.name }

  defaults render_nil: true
end
