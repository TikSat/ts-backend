ActiveAdmin.register Category do
  menu priority: 1

  scope :all, default: true
  scope :root

  index do
    selectable_column
    column :name, sortable: :name
    column :image do |category|
      image_tag category.image_url(:xs)
    end
    column :parent, sortable: 'c.name'
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :parent, as: :select
      f.input :name, label: 'Name'
      f.input :image, as: :file
    end

    f.actions
  end

  controller do
    def scoped_collection
      Category.joins('LEFT JOIN categories c ON c.id = categories.parent_id').select(:name, :parent_id, :created_at, :image_data, :slug)
    end

    def permitted_params
      params.permit!
    end
  end
end
