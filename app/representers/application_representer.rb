require 'roar/decorator'
require 'roar/json'

class ApplicationRepresenter < Roar::Decorator
  include Roar::JSON
  property :type, getter: ->(represented:, **) { represented.class.name.underscore }
  property :decorator, getter: ->(decorator:, **) { decorator.class.name }

  defaults render_nil: true
end
