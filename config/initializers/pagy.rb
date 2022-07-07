# Allow to send custom items count
require 'pagy/extras/items'
Pagy::DEFAULT[:items_extra] = true
Pagy::DEFAULT[:items_param] = :items # default :items
Pagy::DEFAULT[:max_items]   = 100 # default 100

# Instance variables
# See https://ddnexus.github.io/pagy/api/pagy#instance-variables
Pagy::DEFAULT[:page]   = 1                                  # default
Pagy::DEFAULT[:items]  = 20                                 # default
Pagy::DEFAULT[:outset] = 0                                  # default


# Other Variables
# See https://ddnexus.github.io/pagy/api/pagy#other-variables
# Pagy::DEFAULT[:size]       = [1,4,4,1]                       # default
Pagy::DEFAULT[:page_param] = :page # default
# The :params can be also set as a lambda e.g ->(params){ params.exclude('useless').merge!('custom' => 'useful') }
# Pagy::DEFAULT[:params]     = {}                              # default
# Pagy::DEFAULT[:fragment]   = '#fragment'                     # example
# Pagy::DEFAULT[:link_extra] = 'data-remote="true"'            # example
# Pagy::DEFAULT[:i18n_key]   = 'pagy.item_name'                # default
# Pagy::DEFAULT[:cycle]      = true                            # example


# Extras
# See https://ddnexus.github.io/pagy/extras


# Backend Extras

# Array extra: Paginate arrays efficiently, avoiding expensive array-wrapping and without overriding
# See https://ddnexus.github.io/pagy/extras/array
require 'pagy/extras/array'

# Headers extra: http response headers (and other helpers) useful for API pagination
# See http://ddnexus.github.io/pagy/extras/headers
require 'pagy/extras/headers'
Pagy::DEFAULT[:headers] = { page: 'Current-Page',
                            items: 'Page-Items',
                            count: 'Total-Count',
                            pages: 'Total-Pages' }

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
