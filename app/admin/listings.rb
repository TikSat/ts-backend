ActiveAdmin.register Listing do
  menu priority: 3

  index do
    selectable_column
    column :category
    # column :author
    # column :title
    # column :description
    actions
  end

  controller do
    def scoped_collection
      Listing.includes(:author, :category)
    end

    def permitted_params
      params.permit!
    end
  end
end
