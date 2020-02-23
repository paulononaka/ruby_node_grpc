require 'ruson'

class Product < Ruson::Base
  field :id
  field :price_in_cents
  field :title
  field :description
end
