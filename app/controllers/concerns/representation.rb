module Representation
  extend ActiveSupport::Concern

  included do
    after_action { pagy_headers_merge(@pagy) if @pagy }

    def present(object, representer: nil)
      decorator = representer || representer_for(object)
      render = ->(item) { decorator.represent(item).to_hash(params[:response] || {}) if item }

      item = if object.is_a?(ActiveRecord::Relation)
               @pagy, items = pagy(object)
               items.to_a
             else
               object
             end

      render json: render.call(item)
    end

    def representer_for(object)
      obj = object.is_a?(ActiveRecord::Relation) ? object.first : object
      "#{obj.class.name}Representer".constantize
    end
  end
end
