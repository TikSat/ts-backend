class Base::Representer::Success < Base::Representer
  property :status, getter: ->(*) { :ok }
end
