ActiveAdmin.register CustomField do
  menu priority: 2

  index do
    selectable_column
    column :name
    column :field_type do |field|
      field.custom_field_type.split('::').last.titleize
    end
    column :categories
    actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
