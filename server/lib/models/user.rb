require 'ruson'

class User < Ruson::Base
  field :id
  field :first_name
  field :last_name
  field :date_of_birth, class: Ruson::Time
end
