class UserRepresenter < ApplicationRepresenter
  property :id
  property :email
  property :phone
  property :opt_required
  property :allowed_ips
  property :login_count
  property :current_profile, decorator: ->(decorator:, input:, **) { decorator.representer_for(input) }

  def representer_for(object)
    "#{object.class.name}Representer".constantize
  end
end
