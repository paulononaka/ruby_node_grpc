require 'ruson'

class Product < Ruson::Base
  field :id, class: Ruson::Integer
  field :price_in_cents
  field :title
  field :description
end
