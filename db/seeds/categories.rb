IMG_DIR = Rails.root.join('spec/support/images')

def image(name)
  "#{IMG_DIR}/#{name}.jpg"
end

CATEGORIES = [
  {
    name: 'Vehicles',
    image: image('auto'),
    custom_fields: ['Brand', 'Year', 'Model', 'Fuel', 'Brand', 'KM', 'Body Type', 'Engine Power', 'Wheels', 'Doors', 'Color'],
    subcategories: [
      {
        name: 'Auto',
        image: image('auto'),
        subcategories: [
          {
            name: 'Ferrari',
            image: image('auto')
          }
        ]
      },
      {
        name: 'Bikes',
        image: image('auto'),
        subcategories: [
          {
            name: 'Ferrari',
            image: image('auto')
          }
        ]
      }
    ]
  },
  {
    name: 'Real Estate',
    image: image('real_estate'),
    custom_fields: ['Rooms', 'Floor', 'Heating', 'Net square', 'Living square', 'Details'],
    subcategories: [
      {
        name: 'House',
        image: image('real_estate'),
        subcategories: []
      },
      {
        name: 'Flat',
        image: image('real_estate'),
        subcategories: []
      }
    ]
  },
  {
    name: 'Jobs',
    image: image('services'),
    subcategories: []
  },
  {
    name: 'Services',
    image: image('services'),
    subcategories: []
  },
  {
    name: 'Electronics',
    custom_fields: %w[Brand Color Year],
    image: image('electronics'),
    subcategories: [
      {
        name: 'Laptops',
        image: image('electronics'),
        subcategories: [
          {
            name: 'Gamers',
            image: image('electronics'),
            subcategories: [
              {
                name: 'HP',
                image: image('electronics')
              }
            ]
          }
        ]
      },
      {
        name: 'Phones',
        image: image('electronics'),
        subcategories: [
          {
            name: 'Apple',
            image: image('electronics')
          }
        ]
      }
    ]
  }
].freeze

def create_category(hash, **args)
  cat = Category.find_or_initialize_by(name: hash[:name], **args)
  cat.image = File.open(hash[:image])
  custom_fields = CustomField.where(name: hash[:custom_fields])
  cat.custom_fields = custom_fields
  cat.save
  subcategories = hash[:subcategories]
  return if subcategories.blank?

  subcategories.each do |sub|
    create_category(sub, parent_id: cat.id)
  end
end

CATEGORIES.each do |hash|
  create_category(hash)
end
