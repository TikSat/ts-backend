require 'roar/decorator'
require 'roar/json'

class ApplicationRepresenter < Roar::Decorator
  include Roar::JSON
  property :type, getter: ->(represented:, **) { represented.class.name.demodulize.underscore }

  defaults render_nil: true
end
