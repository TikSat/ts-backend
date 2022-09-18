# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 0, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Statistics' do
          para do
            strong "Users: #{User.count}"
          end
          para do
            strong "Listings: #{Listing.count}"
          end
        end
      end
    end
  end # content
end
